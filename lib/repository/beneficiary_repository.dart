import 'dart:async';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/models/Beneficiary.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';
import 'package:get/get.dart';

class BeneficiaryRepository {
  HomeController homeController = Get.find();

  ApiProvider apiProvider;

  Future<List<Beneficiary>> fetchBeneficiaries() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/beneficiaries');
    return beneficiaryFromJson(response);
  }

  Future<Beneficiary> addBeneficiary(data) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.post('peatio/account/beneficiaries', data);

    return response;
  }
}
