import 'dart:convert';

import 'package:b4u_wallet/models/created_savings_model.dart';
import 'package:b4u_wallet/models/plans_model.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';

class SavingsRepository {
  ApiProvider _apiProvider;

  Future<List<Plans>> fetchPlans() async {
    _apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    _apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await _apiProvider.get('peatio/public/savings/plans');
    Iterable l = json.decode(response);
    List<Plans> plans = List<Plans>.from(
      l.map(
        (model) => Plans.fromJson(model),
      ),
    );
    print(plans.length);
    return plans;
  }

  Future<bool> createSavingInvestment(var body) async {
    _apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    _apiProvider.headers = requestHeaders.setAuthHeaders();
    // final body1 = json.encode(body);
    final response = await _apiProvider.post(
        'peatio/account/create_saving_investment', body);
    print(response.toString());
    bool res = json.decode(response);
    return res;
  }
  Future<List<CreatedSavingsModel>> fetchCreatedSavings()async{
    _apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    _apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await _apiProvider.get('peatio/account/saving_investments');
    Iterable l = json.decode(response);
    List<CreatedSavingsModel> plans = List<CreatedSavingsModel>.from(
      l.map(
            (model) => CreatedSavingsModel.fromJson(model),
      ),
    );
    print(plans.length);
    return plans;
  }
}
