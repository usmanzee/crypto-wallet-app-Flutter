import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';

class TradingController extends GetxController {
  // final FormatedMarket formatedMarket = Get.arguments['formatedMarket'];
  var market = FormatedMarket().obs;
  MarketController marketController = Get.find();
  @override
  void onInit() {
    market.value = Get.arguments != null
        ? Get.arguments['formatedMarket']
        : marketController.formatedMarketsList[0];
    super.onInit();
  }

  @override
  void onReady() {
    print('onready Trading');
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
