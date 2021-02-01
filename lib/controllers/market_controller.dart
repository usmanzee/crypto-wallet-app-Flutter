import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/market_ticker.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:crypto_template/screen/market/markets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class MarketController extends GetxController {
  var isLoading = true.obs;
  var marketList = List<Market>().obs;
  var marketTickerList = Map<String, MarketTicker>().obs;
  var formatedMarketsList = List<FormatedMarket>().obs;
  var positiveMarketsList = List<FormatedMarket>().obs;
  var negativeMarketsList = List<FormatedMarket>().obs;
  Rx<FormatedMarket> selectedMarket = FormatedMarket().obs;
  Rx<FormatedMarket> selectedMarketTrading = FormatedMarket().obs;
  ErrorController errorController = new ErrorController();

  @override
  void onInit() async {
    await fetchMarkets();

    // final String wsURL =
    //     'ws://10.121.121.48:9003/api/v2/ranger/public/?stream=api/v2/ranger/private/&stream=balances&stream=btczar.kline-15m&stream=btczar.ob-inc&stream=btczar.trades&stream=global.tickers&stream=order&stream=trade';
    // // final String wsURL =
    // //     'wss://www.coinee.cf/api/v2/ranger/public/?stream=global.tickers';
    // // final String wsURL =
    // //     'wss://ewallet.b4uwallet.com/api/v2/ranger/public/?stream=global.tickers';
    // final channel = await IOWebSocketChannel.connect(wsURL);
    // print(channel);
    // channel.stream.listen((message) {
    //   var data = json.decode(message);
    //   // print(data);
    //   if (data.containsKey('global.tickers')) {
    //     // print(data['global.tickers']);
    //     updateMarketData(data['global.tickers']);
    //   }
    //   // channel.sink.add('received!');
    //   // channel.sink.close(status.goingAway);
    // });

    super.onInit();
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
      print('---WS MAREKTS MESSAGE---');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
