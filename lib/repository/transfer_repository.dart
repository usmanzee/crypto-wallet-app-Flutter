import 'dart:convert';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';
import 'package:b4u_wallet/models/transfer_response.dart';

class TransferRepository{
  ApiProvider apiProvider;

  Future<dynamic> transferAsset(var body) async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('peatio/account/withdraws/transfer', body);
    print(response.toString());
    var a = json.decoder.convert(response);
    final res = TransferResponse.fromJson(a);
    print(res.id);
    return TransferResponse.fromJson(a);
  }

}