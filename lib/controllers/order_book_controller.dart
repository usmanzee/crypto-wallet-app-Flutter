import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';

class OrderBookController extends GetxController {
  var selectedOption = Map<String, String>().obs;
  Rx<FormatedMarket> market = FormatedMarket().obs;
  var formatedKLineData = List<KLineEntity>().obs;
  var isKLineLoading = true.obs;
  var _mainState = MainState.MA.obs;

  var _volHidden = false.obs;
  var _secondaryState = SecondaryState.MACD.obs;

  var _isLine = true.obs;
  var isChinese = false;

  var bidsData = List<DepthEntity>().obs;
  var asksData = List<DepthEntity>().obs;

  MarketController marketController = Get.find();
  WebSocketController webSocketController = Get.find();

  ErrorController errorController = new ErrorController();

  get mainState => this._mainState.value;
  set mainState(index) => this._mainState.value = index;

  get secondaryState => this._secondaryState.value;
  set secondaryState(index) => this._secondaryState.value = index;

  get volHidden => this._volHidden.value;
  set volHidden(index) => this._volHidden.value = index;

  get isLine => this._isLine.value;
  set isLine(index) => this._isLine.value = index;

  @override
  void onInit() async {
    market.value = marketController.selectedMarket.value;

    getWSStreams();

    super.onInit();
  }

  void updateCurrentMarket(FormatedMarket newMarket) async {
    webSocketController.channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": [
        '${market.value.id}.ob-inc',
        '${market.value.id}.kline-' + selectedOption['valueInMinute']
      ]
    }));
    market.value = newMarket;
    marketController.selectedMarket.value = newMarket;

    webSocketController.channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": [
        '${market.value.id}.ob-inc',
        '${market.value.id}.kline-' + selectedOption['valueInMinute']
      ]
    }));
  }

  void updateKlineTimeOption(newOption) async {
    webSocketController.channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": ['${market.value.id}.kline-' + selectedOption['valueInMinute']]
    }));
    selectedOption.value = newOption;

    webSocketController.channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": ['${market.value.id}.kline-' + selectedOption['valueInMinute']]
    }));
  }

  @override
  void onReady() {
    super.onReady();
  }

  bool isArray(String type) {
    return type.lastIndexOf(']') == type.length - 1;
  }

  void getWSStreams() {
    webSocketController.channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": [
        '${market.value.id}.ob-inc',
        '${market.value.id}.kline-' + selectedOption['valueInMinute']
      ]
    }));
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('${market.value.id}.ob-snap')) {
        marketController.asks
            .assignAll(data['${market.value.id}.ob-snap']['asks']);
        marketController.bids
            .assignAll(data['${market.value.id}.ob-snap']['bids']);
      }
      if (data.containsKey('${market.value.id}.ob-inc')) {
        var updatedAsksData = [];
        var updatedBidsData = [];
        if (data['${market.value.id}.ob-inc']['asks'] != null) {
          var asks = data['${market.value.id}.ob-inc']['asks'];
          if (isArray(asks[0].toString())) {
            for (var i = 0; i < asks.length; i++) {
              updatedAsksData = handleIncrementalUpdate(
                  marketController.asks, asks[i], 'asks');
            }
          } else {
            updatedAsksData =
                handleIncrementalUpdate(marketController.asks, asks, 'asks');
          }

          updatedAsksData = updatedAsksData.length >= 25
              ? updatedAsksData.sublist(0, 25)
              : updatedAsksData;
          marketController.asks.assignAll(updatedAsksData);
          marketController.asks.refresh();
        }
        if (data['${market.value.id}.ob-inc']['bids'] != null) {
          var bids = data['${market.value.id}.ob-inc']['bids'];
          if (isArray(bids[0].toString())) {
            for (var i = 0; i < bids.length; i++) {
              updatedBidsData = handleIncrementalUpdate(
                  marketController.bids, bids[i], 'bids');
            }
          } else {
            updatedBidsData =
                handleIncrementalUpdate(marketController.bids, bids, 'bids');
          }
          updatedBidsData = updatedBidsData.length >= 25
              ? updatedBidsData.sublist(0, 25)
              : updatedBidsData;
          marketController.bids.assignAll(updatedBidsData);
          marketController.bids.refresh();
        }
      }
      if (data
          .containsKey('${market.value.id}.kline-' + selectedOption['key'])) {
        var keys = ['time', 'open', 'high', 'low', 'close', 'vol'];
        Map<String, dynamic> newObj = {};
        KLineEntity klineObj;
        for (var i = 0; i < keys.length; i++) {
          var kLineEntry = double.parse(
              data['${market.value.id}.kline-' + selectedOption['key']][i]);
          newObj.addAll({keys[i]: kLineEntry});
        }
        klineObj = new KLineEntity.fromJson(newObj);
        formatedKLineData.add(klineObj);
        DataUtil.calculate(formatedKLineData);
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  dynamic handleIncrementalUpdate(depthOld, newLevel, type) {
    // print(depthOld);
    // print(newLevel);
    // print(type);
    if (newLevel.length != 2) {
      return depthOld;
    }
    var newLevelPrice = double.parse(newLevel[0]);
    var newLevelVolume = double.parse(newLevel[1]);
    var depthNew = [...depthOld];

    if (depthOld.length == 0) {
      return [newLevel];
    }

    for (var index = 0; index < depthOld.length; index++) {
      var levelPrice = double.parse(depthOld[index][0]);
      if (type == 'asks' && newLevelVolume > 0) {
        if (newLevelPrice < levelPrice) {
          splice(depthNew, index, 0, [newLevel]);

          break;
        }

        if (newLevelPrice > levelPrice && index == (depthOld.length - 1)) {
          depthNew.add(newLevel);
          break;
        }
      }

      if (type == 'bids' && newLevelVolume > 0) {
        if (newLevelPrice > levelPrice) {
          splice(depthNew, index, 0, [newLevel]);
          break;
        }

        if (newLevelPrice < levelPrice && index == (depthOld.length - 1)) {
          depthNew.add(newLevel);
          break;
        }
      }

      if (newLevelPrice == levelPrice) {
        if (newLevelVolume == 0) {
          splice(depthNew, index, 1);
        } else {
          splice(depthNew, index, 1, [newLevel]);
        }
        break;
      }
    }
    return depthNew;
  }

  List<T> splice<T>(List<T> list, int index,
      [num howMany = 0, /*<T | List<T>>*/ elements]) {
    var endIndex = index + howMany.truncate();
    list.removeRange(index, endIndex >= list.length ? list.length : endIndex);
    if (elements != null)
      list.insertAll(index, elements is List<T> ? elements : <T>[elements]);
    return list;
  }

  @override
  void onClose() {
    webSocketController.channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": [
        '${market.value.id}.ob-inc',
        '${market.value.id}.kline-' + selectedOption['valueInMinute']
      ]
    }));
    super.onClose();
  }
}
