import 'dart:async';
import 'dart:convert';

import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';

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
    final response = await apiProvider.get(
      'peatio/account/offers'
    );
    Iterable l = json.decode(response);
    List<P2POffer> a =
    List<P2POffer>.from(l.map((model) => P2POffer.fromJson(model)));
    return a;
  }
}
