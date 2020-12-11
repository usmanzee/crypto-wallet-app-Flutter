import 'dart:async';
import 'dart:convert';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/market_ticker.dart';

class MarketRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<List<Market>> fetchMarkets() async {
    final response = await apiProvider.get('peatio/public/markets');
    return marketFromJson(response);
  }

  Future<Map<String, MarketTicker>> fetchMarketsTickers() async {
    final response = await apiProvider.get('peatio/public/markets/tickers');
    return marketTickerFromJson(response);
  }
}
