import 'dart:async';
import 'package:crypto_template/models/open_order.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/network/request_headers.dart';

class OpenOrdersRepository {
  ApiProvider apiProvider;

  Future<List<OpenOrder>> fetchOpenOrders(String marketId) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider
        .get('peatio/market/orders?market=${marketId}&state=wait');
    return openOrderFromJson(response);
  }

  Future<dynamic> cancelOpenOrders(bool cancelAll, [int orderId]) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    var url = 'peatio/market/orders/cancel';
    url = orderId != null ? url + '/' + orderId.toString() : url;
    final response = await apiProvider.get(url);
    return response;
  }
}
