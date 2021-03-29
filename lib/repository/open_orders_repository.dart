import 'dart:async';
import 'dart:convert';
import 'package:b4u_wallet/models/open_order.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';

class OpenOrdersRepository {
  ApiProvider apiProvider;

  Future<List<OpenOrder>> fetchOpenOrders(String marketId) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    // var url = 'peatio/market/orders?market=${marketId}&state=wait';
    var url = 'peatio/market/orders?state=wait';
    final response = await apiProvider.get(url);
    return openOrderFromJson(response);
  }

  Future<OpenOrder> cancelOpenOrder(int orderId, dynamic reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    // var url = 'peatio/market/orders/cancel/${orderId}';
    var url = 'peatio/market/orders/${orderId}/cancel';
    final response = await apiProvider.post(url, reqObj);
    return OpenOrder.fromJson(json.decode(response));
  }

  Future<List<OpenOrder>> cancelAllOpenOrders(dynamic reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    var url = 'peatio/market/orders/cancel';
    final response = await apiProvider.post(url, reqObj);
    return openOrderFromJson(response);
  }
}
