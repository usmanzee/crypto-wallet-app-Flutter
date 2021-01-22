import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:crypto_template/screen/market/markets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';

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
  void onInit() {
    print('init');
    market.value = Get.arguments['formatedMarket'];
    setDefaultValues();
    getKlineData();
    rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      Map tick = parseJson['tick'];
      var bids = tick['bids']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      var asks = tick['asks']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      initDepth(bids, asks);
    });
    super.onInit();
  }

  void updateCurrentMarket(FormatedMarket newMarket) {
    market.value = newMarket;
    getKlineData();
  }

  @override
  void onReady() {
    print('onready');
    super.onReady();
  }

  void setDefaultValues() {
    selectedOption.assignAll(lineGraphTimeSlots[2]);
  }

  void getKlineData() async {
    MarketRepository _marketRepository = new MarketRepository();
    try {
      isKLineLoading(true);
      var period = selectedOption['valueInMinute'];
      var market = formatedMarket.id;
      var currentTime = DateTime.now();
      var from = currentTime.millisecondsSinceEpoch;
      var to = currentTime
          .add(new Duration(minutes: int.parse(period)))
          .millisecondsSinceEpoch;
      var data =
          await _marketRepository.fetchKLineData(market, period, from, to);
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

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;

    double amount = 0.0;
    bids?.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      bidsData.insert(0, item);
    });

    amount = 0.0;
    asks?.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks?.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      asksData.add(item);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
