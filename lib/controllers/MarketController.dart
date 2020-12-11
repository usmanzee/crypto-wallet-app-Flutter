import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/market_ticker.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:crypto_template/screen/market/markets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketController extends GetxController {
  var isLoading = true.obs;
  var marketList = List<Market>().obs;
  var marketTickerList = Map<String, MarketTicker>().obs;
  var formatedMarketsList = List<FormatedMarket>().obs;
  var positiveMarketsList = List<FormatedMarket>().obs;
  var negativeMarketsList = List<FormatedMarket>().obs;
  SnackbarController snackbarController;

  @override
  void onInit() {
    fetchMarkets();
    super.onInit();
  }

  void fetchMarkets() async {
    MarketRepository _marketRepository = new MarketRepository();
    try {
      isLoading(true);
      var markets = await _marketRepository.fetchMarkets();
      var marketsTickers = await _marketRepository.fetchMarketsTickers();
      marketList.value = markets;
      marketTickerList.value = marketsTickers;
      formateMarkets(markets, marketsTickers);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      var errorResponseObj = error.errorResponse();
      snackbarController = new SnackbarController(
          title: 'Error', message: errorResponseObj['message']);
      snackbarController.showSnackbar();
    }
  }

  void formateMarkets(
      List<Market> markets, Map<String, MarketTicker> tickers) async {
    var marketsFormatedData = new List<FormatedMarket>();
    var positivemarketsFormatedData = new List<FormatedMarket>();
    var negativemarketsFormatedData = new List<FormatedMarket>();
    for (Market market in markets) {
      if (tickers[market.id] != null) {
        bool isPositiveChange = true;
        double marketLast = double.parse(tickers[market.id].ticker.last);
        double marketOpen = double.parse(tickers[market.id].ticker.open);
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

      formatedMarketsList.value = marketsFormatedData;
      positiveMarketsList.value = positivemarketsFormatedData;
      negativeMarketsList.value = negativemarketsFormatedData;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
