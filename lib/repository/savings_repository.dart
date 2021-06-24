import 'dart:convert';

import 'package:b4u_wallet/models/plans_model.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';

class SavingsRepository{
  ApiProvider apiProvider;

  Future<List<Plans>> fetchPlans() async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/plans');
    // List<Plans> res = json.decoder.convert(response.toString(),);
    // print(res);
    Iterable l = json.decode(response);
    List<Plans> plans = List<Plans>.from(l.map((model)=> Plans.fromJson(model)));
    print(plans.length);
    print(plans.iterator);
    return plans;
  }
}