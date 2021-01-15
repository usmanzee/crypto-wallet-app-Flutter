import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';

class MarketDetailController extends GetxController {
  final FormatedMarket formatedMarket;
  MarketDetailController({this.formatedMarket});

  var graphTypes = [
    {
      "name": "Line",
      "options": [
        {"key": "1m", "name": "1 minute", "valueInMinute": "1"},
        {"key": "5m", "name": "5 minutes", "valueInMinute": "5"},
        {"key": "15m", "name": "15 minutes", "valueInMinute": "15"},
        {"key": "30m", "name": "30 minutes", "valueInMinute": "30"},
        {"key": "1h", "name": "1 hour", "valueInMinute": "1"},
        {"key": "2h", "name": "2 hours", "valueInMinute": "1"},
        {"key": "6h", "name": "6 hours", "valueInMinute": "1"},
        {"key": "12h", "name": "12 hour", "valueInMinute": "1"},
        {"key": "3D", "name": "3 days", "valueInMinute": "1"},
        {"key": "1w", "name": "1 week", "valueInMinute": "1"},
        {"key": "1M", "name": "1 month", "valueInMinute": "1"},
      ]
    },
    {"name": "Depth", "options": []}
  ].obs;
  var selectedGraph = Map<String, Object>().obs;
  var selectedOption = ''.obs;

  List<KLineEntity> newData = new List<KLineEntity>(), obs;
  var isKLineLoading = true.obs;
  var _mainState = MainState.MA.obs;

  var _volHidden = false.obs;
  var _secondaryState = SecondaryState.MACD.obs;

  var _isLine = true.obs;
  var isChinese = false;

  var _bids = List<DepthEntity>().obs;
  var _asks = List<DepthEntity>().obs;

  var negativeMarketsList = List<FormatedMarket>().obs;
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
    setDefaultValues();
    super.onInit();
  }

  void getKlineData() {}

  void setDefaultValues() {
    selectedGraph.assignAll(graphTypes[0]);
    selectedOption.value = '1min';
  }

  @override
  void onClose() {
    super.onClose();
  }
}
