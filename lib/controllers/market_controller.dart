import 'dart:async';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/market_ticker.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class MarketController extends GetxController {
  var isLoading = true.obs;
  var marketList = List<Market>().obs;
  var marketTickerList = Map<String, MarketTicker>().obs;
  var formatedMarketsList = List<FormatedMarket>().obs;
  var positiveMarketsList = List<FormatedMarket>().obs;
  var negativeMarketsList = List<FormatedMarket>().obs;
  var orderBookSequence = -1.obs;
  var bids = List<dynamic>().obs;
  var asks = List<dynamic>().obs;
  var maxVolume = 0.0.obs;
  var orderBookEntryBids = List<dynamic>().obs;
  var orderBookEntryAsks = List<dynamic>().obs;
  Rx<IOWebSocketChannel> channel;
  Rx<FormatedMarket> selectedMarket = FormatedMarket().obs;
  Rx<FormatedMarket> selectedMarketTrading = FormatedMarket().obs;
  ErrorController errorController = new ErrorController();
  WebSocketController webSocketController;

  @override
  void onInit() async {
    isLoading(true);
    await fetchMarkets();
    webSocketController = Get.find<WebSocketController>();
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('global.tickers')) {
        updateMarketData(data['global.tickers']);
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });

    super.onInit();
  }

  void onReady() {
    super.onReady();
  }

  Future<void> fetchMarkets() async {
    MarketRepository _marketRepository = new MarketRepository();
    try {
      isLoading(true);
      var markets = await _marketRepository.fetchMarkets();
      var marketsTickers = await _marketRepository.fetchMarketsTickers();
      marketList.assignAll(markets);
      marketTickerList.assignAll(marketsTickers);
      formateMarkets(markets, marketsTickers);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  void formateMarkets(
      List<Market> markets, Map<String, dynamic> tickers) async {
    var marketsFormatedData = new List<FormatedMarket>();
    var positivemarketsFormatedData = new List<FormatedMarket>();
    var negativemarketsFormatedData = new List<FormatedMarket>();
    for (Market market in markets) {
      if (tickers[market.id] != null) {
        var priceInUsd = '---';
        bool isPositiveChange = true;
        double marketLast = double.parse(tickers[market.id].ticker.last);
        double marketOpen = tickers[market.id].ticker.open.runtimeType != double
            ? double.parse(tickers[market.id].ticker.open)
            : tickers[market.id].ticker.open;
        String marketPriceChangePercent =
            tickers[market.id].ticker.priceChangePercent;
        double marketHigh = double.parse(tickers[market.id].ticker.high);
        double marketLow = double.parse(tickers[market.id].ticker.low);
        double marketVolume = double.parse(tickers[market.id].ticker.volume);
        double change = (marketLast - marketOpen);
        if (change < 0) {
          isPositiveChange = false;
        }
        priceInUsd = market.quoteUnit == 'usd'
            ? priceInUsd = marketLast.toStringAsFixed(2)
            : getBaseUnitPriceInUsd(market.baseUnit, tickers, false);
        var formatedMarket = new FormatedMarket(
            id: market.id,
            name: market.name,
            baseUnit: market.baseUnit,
            quoteUnit: market.quoteUnit,
            minPrice: market.minPrice,
            maxPrice: market.maxPrice,
            priceInUsd: priceInUsd,
            amountPrecision: market.amountPrecision,
            pricePrecision: market.pricePrecision,
            state: market.state,
            isPositiveChange: isPositiveChange,
            buy: tickers[market.id].ticker.buy,
            sell: tickers[market.id].ticker.sell,
            low: marketLow,
            high: marketHigh,
            open: marketOpen,
            last: marketLast,
            volume: marketVolume,
            avgPrice: tickers[market.id].ticker.avgPrice,
            priceChangePercent: marketPriceChangePercent,
            vol: tickers[market.id].ticker.vol);
        if (isPositiveChange) {
          positivemarketsFormatedData.add(formatedMarket);
        } else {
          negativemarketsFormatedData.add(formatedMarket);
        }
        marketsFormatedData.add(formatedMarket);
      }
    }
    formatedMarketsList.assignAll(marketsFormatedData);
    selectedMarket.value = formatedMarketsList[0];
    selectedMarketTrading.value = formatedMarketsList[0];
    positiveMarketsList.assignAll(positivemarketsFormatedData);
    negativeMarketsList.assignAll(negativemarketsFormatedData);
  }

  String getBaseUnitPriceInUsd(
      String baseUnit, Map<String, dynamic> tickers, bool fromWebSocket) {
    var priceInUsd = '---';

    var market = marketList.firstWhere(
        (market) =>
            market.baseUnit.toLowerCase() == baseUnit.toLowerCase() &&
            market.quoteUnit == 'usd',
        orElse: () => null);
    if (market != null) {
      double lastPrice = fromWebSocket
          ? double.parse(tickers[market.id]['last'])
          : double.parse(tickers[market.id].ticker.last);
      priceInUsd = lastPrice.toStringAsFixed(2);
    }
    return priceInUsd;
  }

  void updateMarketData(tickers) {
    for (FormatedMarket market in formatedMarketsList) {
      if (tickers[market.id] != null) {
        var priceInUsd = '---';
        bool isPositiveChange = true;
        double marketLast = double.parse(tickers[market.id]['last']);
        double marketOpen = tickers[market.id]['open'].runtimeType != double
            ? double.parse(tickers[market.id]['open'])
            : tickers[market.id]['open'];
        String marketPriceChangePercent =
            tickers[market.id]['price_change_percent'];
        double marketHigh = double.parse(tickers[market.id]['high']);
        double marketLow = double.parse(tickers[market.id]['low']);
        double marketVolume = double.parse(tickers[market.id]['volume']);
        double change = (marketLast - marketOpen);
        if (change < 0) {
          isPositiveChange = false;
        }
        priceInUsd = market.quoteUnit == 'usd'
            ? priceInUsd = marketLast.toStringAsFixed(2)
            : getBaseUnitPriceInUsd(market.baseUnit, tickers, true);
        market.avgPrice = tickers[market.id]['avg_price'];
        market.high = marketHigh;
        market.last = marketLast;
        market.priceInUsd = priceInUsd;
        market.low = marketLow;
        market.open = marketOpen;
        market.priceChangePercent = marketPriceChangePercent;
        market.volume = marketVolume;
        isPositiveChange = isPositiveChange;
        if (selectedMarket.value.id == market.id) {
          selectedMarket.value = market;
          selectedMarket.refresh();
        }
        if (selectedMarketTrading.value.id == market.id) {
          selectedMarketTrading.value = market;
          selectedMarketTrading.refresh();
        }
        int positiveExistingIndex = positiveMarketsList
            .indexWhere((element) => element.id == market.id);
        int negativeExistingIndex = negativeMarketsList
            .indexWhere((element) => element.id == market.id);
        if (isPositiveChange) {
          if (positiveExistingIndex != -1) {
            positiveMarketsList[positiveExistingIndex] = market;
          } else {
            positiveMarketsList.add(market);
            if (negativeExistingIndex != -1) {
              negativeMarketsList.removeAt(negativeExistingIndex);
            }
          }
        } else {
          if (negativeExistingIndex != -1) {
            negativeMarketsList[negativeExistingIndex] = market;
          } else {
            negativeMarketsList.add(market);
            if (positiveExistingIndex != -1) {
              positiveMarketsList.removeAt(positiveExistingIndex);
            }
          }
        }

        //Update Tickers List
        marketTickerList[market.id].ticker.high = marketHigh.toString();
        marketTickerList[market.id].ticker.low = marketLow.toString();
        marketTickerList[market.id].ticker.open = marketOpen.toString();
        marketTickerList[market.id].ticker.last = marketLast.toString();
        marketTickerList[market.id].ticker.volume = marketVolume.toString();
        marketTickerList[market.id].ticker.avgPrice =
            tickers[market.id]['avg_price'];
        marketTickerList[market.id].ticker.priceChangePercent =
            marketPriceChangePercent;
      }
      formatedMarketsList.refresh();
      positiveMarketsList.refresh();
      negativeMarketsList.refresh();
      // print('---WS MAREKTS MESSAGE---');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
