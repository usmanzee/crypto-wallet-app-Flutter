import 'dart:async';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/models/trading_order_response.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/network/request_headers.dart';

class TradingRepository {
  HomeController homeController = Get.find();

  ApiProvider apiProvider;

  Future<TradingOrderResponse> placeTradingOrder(orderObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('peatio/market/orders', orderObj);
    print(response);
    return tradingOrderResponseFromJson(response);
  }
}
