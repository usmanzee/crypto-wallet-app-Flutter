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
  var bids = List<dynamic>().obs;
  var asks = List<dynamic>().obs;
  Rx<IOWebSocketChannel> channel;
  Rx<FormatedMarket> selectedMarket = FormatedMarket().obs;
  Rx<FormatedMarket> selectedMarketTrading = FormatedMarket().obs;
  ErrorController errorController = new ErrorController();
  WebSocketController webSocketController;

  Rx<StreamController> streamController;

  @override
  void onInit() async {
    await fetchMarkets();
    webSocketController = Get.put(WebSocketController());
    await webSocketController.connectToWebSocket(false, selectedMarket.value);

    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('global.tickers')) {
        updateMarketData(data['global.tickers']);
      }
      // if (data.containsKey('btczar.ob-snap')) {
      //   asks.assignAll(data['btczar.ob-snap']['asks']);
      //   bids.assignAll(data['btczar.ob-snap']['bids']);
      // }
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

  void fetchMarkets() async {
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
      print(error);
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
        var formatedMarket = new FormatedMarket(
            id: market.id,
            name: market.name,
            baseUnit: market.baseUnit,
            quoteUnit: market.quoteUnit,
            minPrice: market.minPrice,
            maxPrice: market.maxPrice,
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

  void updateMarketData(tickers) {
    for (FormatedMarket market in formatedMarketsList) {
      if (tickers[market.id] != null) {
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
        market.avgPrice = tickers[market.id]['avg_price'];
        market.high = marketHigh;
        market.last = marketLast;
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
        int positiveExistingIndex = positiveMarketsList.value
            .indexWhere((element) => element.id == market.id);
        int negativeExistingIndex = negativeMarketsList.value
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
