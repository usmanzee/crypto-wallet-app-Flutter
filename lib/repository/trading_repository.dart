import 'dart:async';
import 'dart:convert';
import 'package:b4u_wallet/models/trading_fee.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';
import 'package:b4u_wallet/models/open_order.dart';

class TradingRepository {
  HomeController homeController = Get.find();

  ApiProvider apiProvider;

  Future<OpenOrder> placeTradingOrder(orderObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('peatio/market/orders', orderObj);
    return OpenOrder.fromJson(json.decode(response));
  }

  Future<TradingFee> fetchTradingFee() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/member_fee');
    return tradingFeeFromJson(response);
  }
}
