import 'dart:async';
import 'dart:convert';

import 'package:b4u_wallet/models/p2p_currency.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/models/payment_method/payment_method.dart';
import 'package:b4u_wallet/models/payment_method/payment_method_data.dart';
import 'package:b4u_wallet/models/payment_method/payment_method_detail.dart';
import 'package:b4u_wallet/models/payment_method/payment_method_options.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';
import 'package:flutter/material.dart';

class P2pRepository {
  ApiProvider apiProvider;

  Future<List<P2POffer>> fetchP2pOffers({String category}) async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    // final response = await apiProvider.get('peatio/account/offers/',);
    final response = await apiProvider.get(
      'peatio/public/p2p/offers/?base_unit=$category',
    );
    Iterable l = json.decode(response);
    List<P2POffer> a =
    List<P2POffer>.from(l.map((model) => P2POffer.fromJson(model)));
    return a;
  }

  Future<P2POffer> addP2pOffer(Map<String, dynamic> body) async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('peatio/account/offers', body);
    print(response.toString());
    final P2POffer _p2pOffer = P2POffer.fromJson(response);
    return _p2pOffer;
  }

  Future<List<P2POffer>> fetchUserP2pAddedOffers() async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    // final response = await apiProvider.get('peatio/account/offers/',);
    final response = await apiProvider.get('peatio/account/offers');
    Iterable l = json.decode(response);
    List<P2POffer> a =
    List<P2POffer>.from(l.map((model) => P2POffer.fromJson(model)));
    return a;
  }

  Future<String> fetchExchangeRate(
      {@required Map<String, dynamic> body}) async {
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
    await apiProvider.post('peatio/account/exchanges/rate', body);
    // print(response);
    // print(json.decode(response));
    return json.decode(response);
  }

  Future<List<P2PCurrency>> fetchCurrencies() async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    // final response = await apiProvider.get('peatio/account/offers/',);
    final response = await apiProvider.get('peatio/public/currencies');
    Iterable l = json.decode(response);
    // print(l.toString());
    List<P2PCurrency> a =
    List<P2PCurrency>.from(l.map((model) => P2PCurrency.fromJson(model)));
    return a;
  }

  Future<List<PaymentMethod>> fetchPaymentMethodList() async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/public/payment_methods');
    Iterable l = json.decode(response);
    print(l.toString());
    List<PaymentMethod> a = List<PaymentMethod>.from(
        l.map((model) => PaymentMethod.fromJson(model)));
    return a;
  }

  Future<List<PaymentMethodDetail>> selectedPublicMethodDetails({
    @required String selectedMethod}) async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider
        .get('peatio/account/p2p/payment_methods/details/$selectedMethod');
    final re = json.decode(response);
    //there is a json inside a json :v)
    final r = json.decode(re[0]['options']);
    Iterable l = r;
    List<PaymentMethodDetail> a = List<PaymentMethodDetail>.from(
        l.map((model) => PaymentMethodDetail.fromJson(model)));
    a.forEach((element) {
      print(element.toJson());
    });
    return a;
  }

  Future<bool> addPaymentMethod(dynamic body) async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post(
        'peatio/account/p2p/user/payment_methods', body);
    final res = json.decode(response);
    if (res) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PaymentMethodData>> fetchAllAddedPaymentMethods() async {
    apiProvider = ApiProvider();
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get(
        'peatio/account/p2p/user/payment_methods');
    Iterable l = json.decode(response);
    print(l.toString());
    List<PaymentMethodData> a = List<PaymentMethodData>.from(
        l.map((model) => PaymentMethodData.fromJson(model)));
    return a;
  }
}
