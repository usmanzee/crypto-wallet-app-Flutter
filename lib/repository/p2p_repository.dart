import 'dart:convert';
import 'dart:async';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';

class P2pRepository{
  ApiProvider apiProvider;

  Future<List<P2POffer>> fetchP2pOffers({String category})async{
    apiProvider =  ApiProvider();
    // final response = await apiProvider.get('peatio/account/offers/?base_unit=$category',);
    RequestHeaders requestHeaders = RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/offers/',);
    Iterable l = json.decode(response);
    List<P2POffer> a = List<P2POffer>.from(l.map((model)=> P2POffer.fromJson(model)));
    return a;
  }
}