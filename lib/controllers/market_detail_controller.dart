import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:crypto_template/screen/market/markets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:crypto_template/utils/Helpers/ws_helper.dart';

class MarketDetailController extends GetxController {
  final FormatedMarket formatedMarket = Get.arguments['formatedMarket'];

  var lineGraphTimeSlots = [
    {"key": "1m", "name": "1 minute", "valueInMinute": "1"},
    {"key": "5m", "name": "5 minutes", "valueInMinute": "5"},
    {"key": "15m", "name": "15 minutes", "valueInMinute": "15"},
    {"key": "30m", "name": "30 minutes", "valueInMinute": "30"},
    {"key": "1h", "name": "1 hour", "valueInMinute": "60"},
    {"key": "2h", "name": "2 hours", "valueInMinute": "120"},
    {"key": "6h", "name": "6 hours", "valueInMinute": "360"},
    {"key": "12h", "name": "12 hour", "valueInMinute": "720"},
    {"key": "3D", "name": "3 days", "valueInMinute": "4320"},
    {"key": "1w", "name": "1 week", "valueInMinute": "10080"},
    {"key": "1M", "name": "1 month", "valueInMinute": "43800"},
  ].obs;
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
    await setDefaultValues();
    await getKlineData();
    // rootBundle.loadString('assets/depth.json').then((result) {
    //   final parseJson = json.decode(result);
    //   Map tick = parseJson['tick'];
    //   var bids = tick['bids']
    //       .map((item) => DepthEntity(item[0], item[1]))
    //       .toList()
    //       .cast<DepthEntity>();
    //   var asks = tick['asks']
    //       .map((item) => DepthEntity(item[0], item[1]))
    //       .toList()
    //       .cast<DepthEntity>();

    //   initDepth(bids, asks);
    // });

    super.onInit();
  }

  @override
  void onReady() async {
    // getWSStreams();
    await webSocketController.subscribeKline(
        market.value, selectedOption['valueInMinute']);
    getKlineDataFromWS();

    await webSocketController.subscribeOrderBookInc(market.value);
    getOrderBookDataFromWS();
    super.onReady();
  }

  void updateCurrentMarket(FormatedMarket newMarket) async {
    webSocketController.unSubscribeKline(
        market.value, selectedOption['valueInMinute']);
    webSocketController.unSubscribeOrderBookInc(market.value);
    market.value = newMarket;
    marketController.selectedMarket.value = newMarket;

    await getKlineData();
    webSocketController.subscribeKline(
        newMarket, selectedOption['valueInMinute']);
    webSocketController.subscribeOrderBookInc(newMarket);
  }

  void updateKlineTimeOption(newOption) async {
    webSocketController.unSubscribeKline(
        market.value, selectedOption['valueInMinute']);

    selectedOption.value = newOption;
    await getKlineData();
    webSocketController.subscribeKline(
        market.value, selectedOption['valueInMinute']);
  }

  void setDefaultValues() {
    selectedOption.assignAll(lineGraphTimeSlots[2]);
  }

  void getKlineData() async {
    MarketRepository _marketRepository = new MarketRepository();
    try {
      isKLineLoading(true);
      var period = selectedOption['valueInMinute'];
      var currentTime = DateTime.now();
      // var from = currentTime.millisecondsSinceEpoch;
      // var to = currentTime
      //     .add(new Duration(minutes: int.parse(period)))
      //     .millisecondsSinceEpoch;
      var from = currentTime.millisecondsSinceEpoch;
      var to =
          currentTime.subtract(new Duration(days: 3)).millisecondsSinceEpoch;
      var data = await _marketRepository.fetchKLineData(
          market.value.id, period, from, to);
      var keys = ['time', 'open', 'high', 'low', 'close', 'vol'];
      for (var i = 0; i < data.length; i++) {
        Map<String, dynamic> newObj = {};
        KLineEntity klineObj;
        for (var j = 0; j < keys.length; j++) {
          newObj.addAll({keys[j]: data[i][j]});
        }

        klineObj = new KLineEntity.fromJson(newObj);
        formatedKLineData.add(klineObj);
        DataUtil.calculate(formatedKLineData);
        isKLineLoading(false);
      }
    } catch (error) {
      isKLineLoading(false);
      print(error);
      errorController.handleError(error);
    }
  }

  void makeDepthData() {
    var bids = marketController.bids
        .map(
            (item) => DepthEntity(double.parse(item[0]), double.parse(item[1])))
        .toList()
        .cast<DepthEntity>();
    var asks = marketController.asks
        .map(
            (item) => DepthEntity(double.parse(item[0]), double.parse(item[1])))
        .toList()
        .cast<DepthEntity>();
    initDepth(bids, asks);
  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;

    double amount = 0.0;
    bids?.sort((left, right) => left.price.compareTo(right.price));
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      bidsData.insert(0, item);
    });

    amount = 0.0;
    asks?.sort((left, right) => left.price.compareTo(right.price));
    asks?.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      asksData.add(item);
    });
  }

  void getKlineDataFromWS() {
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
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
      print("K Line data done");
    }, onError: (error) {
      print("K Line data Error");
    });
  }

  void getOrderBookDataFromWS() {
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('${market.value.id}.ob-snap')) {
        marketController.asks
            .assignAll(data['${market.value.id}.ob-snap']['asks']);
        marketController.bids
            .assignAll(data['${market.value.id}.ob-snap']['bids']);

        makeDepthData();
      }
      if (data.containsKey('${market.value.id}.ob-inc')) {
        var updatedAsksData = [];
        var updatedBidsData = [];
        if (data['${market.value.id}.ob-inc']['asks'] != null) {
          var asks = data['${market.value.id}.ob-inc']['asks'];
          if (WsHelper.isArray(asks[0].toString())) {
            for (var i = 0; i < asks.length; i++) {
              updatedAsksData = WsHelper.handleIncrementalUpdate(
                  marketController.asks, asks[i], 'asks');
            }
          } else {
            updatedAsksData = WsHelper.handleIncrementalUpdate(
                marketController.asks, asks, 'asks');
          }

          updatedAsksData = updatedAsksData.length >= 10
              ? updatedAsksData.sublist(0, 10)
              : updatedAsksData;
          marketController.asks.assignAll(updatedAsksData);
          marketController.asks.refresh();
          // makeDepthData();
        }
        if (data['${market.value.id}.ob-inc']['bids'] != null) {
          var bids = data['${market.value.id}.ob-inc']['bids'];
          if (WsHelper.isArray(bids[0].toString())) {
            for (var i = 0; i < bids.length; i++) {
              updatedBidsData = WsHelper.handleIncrementalUpdate(
                  marketController.bids, bids[i], 'bids');
            }
          } else {
            updatedBidsData = WsHelper.handleIncrementalUpdate(
                marketController.bids, bids, 'bids');
          }
          updatedBidsData = updatedBidsData.length >= 10
              ? updatedBidsData.sublist(0, 10)
              : updatedBidsData;
          marketController.bids.assignAll(updatedBidsData);
          marketController.bids.refresh();
          // makeDepthData();
        }
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  // void getWSStreams() {
  //   webSocketController.channel.value.sink.add(json.encode({
  //     "event": "subscribe",
  //     "streams": [
  //       '${market.value.id}.ob-inc',
  //       '${market.value.id}.kline-' + selectedOption['valueInMinute']
  //     ]
  //   }));
  //   webSocketController.streamController.value.stream.listen((message) {
  //     var data = json.decode(message);
  //     if (data.containsKey('${market.value.id}.ob-snap')) {
  //       marketController.asks
  //           .assignAll(data['${market.value.id}.ob-snap']['asks']);
  //       marketController.bids
  //           .assignAll(data['${market.value.id}.ob-snap']['bids']);

  //       makeDepthData();
  //     }
  //     if (data.containsKey('${market.value.id}.ob-inc')) {
  //       print(data);
  //       var updatedAsksData = [];
  //       var updatedBidsData = [];
  //       if (data['${market.value.id}.ob-inc']['asks'] != null) {
  //         var asks = data['${market.value.id}.ob-inc']['asks'];
  //         if (WsHelper.isArray(asks[0].toString())) {
  //           for (var i = 0; i < asks.length; i++) {
  //             updatedAsksData = WsHelper.handleIncrementalUpdate(
  //                 marketController.asks, asks[i], 'asks');
  //           }
  //         } else {
  //           updatedAsksData = WsHelper.handleIncrementalUpdate(
  //               marketController.asks, asks, 'asks');
  //         }

  //         updatedAsksData = updatedAsksData.length >= 10
  //             ? updatedAsksData.sublist(0, 10)
  //             : updatedAsksData;
  //         marketController.asks.assignAll(updatedAsksData);
  //         marketController.asks.refresh();
  //         // makeDepthData();
  //       }
  //       if (data['${market.value.id}.ob-inc']['bids'] != null) {
  //         var bids = data['${market.value.id}.ob-inc']['bids'];
  //         if (WsHelper.isArray(bids[0].toString())) {
  //           for (var i = 0; i < bids.length; i++) {
  //             updatedBidsData = WsHelper.handleIncrementalUpdate(
  //                 marketController.bids, bids[i], 'bids');
  //           }
  //         } else {
  //           updatedBidsData = WsHelper.handleIncrementalUpdate(
  //               marketController.bids, bids, 'bids');
  //         }
  //         updatedBidsData = updatedBidsData.length >= 10
  //             ? updatedBidsData.sublist(0, 10)
  //             : updatedBidsData;
  //         marketController.bids.assignAll(updatedBidsData);
  //         marketController.bids.refresh();
  //         // makeDepthData();
  //       }
  //     }
  //     if (data
  //         .containsKey('${market.value.id}.kline-' + selectedOption['key'])) {
  //       var keys = ['time', 'open', 'high', 'low', 'close', 'vol'];
  //       Map<String, dynamic> newObj = {};
  //       KLineEntity klineObj;
  //       for (var i = 0; i < keys.length; i++) {
  //         var kLineEntry = double.parse(
  //             data['${market.value.id}.kline-' + selectedOption['key']][i]);
  //         newObj.addAll({keys[i]: kLineEntry});
  //       }
  //       klineObj = new KLineEntity.fromJson(newObj);
  //       formatedKLineData.add(klineObj);
  //       DataUtil.calculate(formatedKLineData);
  //     }
  //   }, onDone: () {
  //     print("Task Done1");
  //   }, onError: (error) {
  //     print("Some Error1");
  //   });
  // }

  @override
  void onClose() {
    webSocketController.unSubscribeKline(
        market.value, selectedOption['valueInMinute']);
    webSocketController.unSubscribeOrderBookInc(market.value);
    super.onClose();
  }
}
