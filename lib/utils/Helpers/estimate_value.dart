import 'package:crypto_template/models/currency.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/market_ticker.dart';
import 'package:crypto_template/models/wallet.dart';

class EstimatedValue {
  static final defaultCCYPercision = 5;
  static Market findMarket(
      String askUnit, String bidUnit, List<Market> markets) {
    for (Market market in markets) {
      if ((market.baseUnit == askUnit && market.quoteUnit == bidUnit) ||
          (market.baseUnit == bidUnit && market.quoteUnit == askUnit)) {
        return market;
      }
    }

    return null;
  }

  static bool isMarketPresent(
      String askUnit, String bidUnit, List<Market> markets) {
    return (findMarket(askUnit, bidUnit, markets) != null);
  }

  static findMarketTicker(
      String marketPair, Map<String, MarketTicker> marketTickers) {
    return marketTickers[marketPair];
  }

  static int handleCCYPrecision(
      List<Currency> currencies, String currency, int defaultPrecision) {
    var precisableCCY = currencies.firstWhere(
        (item) => item.id.toLowerCase() == currency.toLowerCase(),
        orElse: () => null);
    return precisableCCY != null ? precisableCCY.precision : defaultPrecision;
  }

  static double getWalletTotal(Wallet wallet) {
    return double.parse(wallet.balance) + double.parse(wallet.locked);
  }

  static double estimateWithMarket(
      String targetCurrency,
      String walletCurrency,
      double walletTotal,
      List<Currency> currencies,
      List<Market> markets,
      Map<String, MarketTicker> marketTickers) {
    var formattedTargetCurrency = targetCurrency.toLowerCase();
    var formattedWalletCurrency = walletCurrency.toLowerCase();
    var market =
        findMarket(formattedTargetCurrency, formattedWalletCurrency, markets);
    var marketTicker = findMarketTicker(
        (market != null && market.id != '') ? market.id : '', marketTickers);
    var targetCurrencyPrecision = handleCCYPrecision(
        currencies, formattedTargetCurrency, defaultCCYPercision);

    if (formattedTargetCurrency == formattedWalletCurrency) {
      return double.parse(walletTotal.toStringAsFixed(targetCurrencyPrecision));
    }

    if (market != null && marketTicker != null) {
      if (formattedTargetCurrency == market.baseUnit) {
        var precisedValue = double.parse((walletTotal *
                (double.parse(marketTicker.ticker.last) != 0
                    ? 1 / double.parse(marketTicker.ticker.last)
                    : 0))
            .toStringAsFixed(targetCurrencyPrecision));

        return precisedValue;
      } else {
        var precisedValue = double.parse(
            (walletTotal * double.parse(marketTicker.ticker.last))
                .toStringAsFixed(targetCurrencyPrecision));

        return precisedValue;
      }
    }

    return 0.0;
  }

  static double estimateWithoutMarket(
      String targetCurrency,
      String walletCurrency,
      double walletTotal,
      List<Currency> currencies,
      List<Market> markets,
      Map<String, MarketTicker> marketTickers) {
    List<String> secondaryCurrencies = [];
    var formattedTargetCurrency = targetCurrency.toLowerCase();
    var formattedWalletCurrency = walletCurrency.toLowerCase();

    for (Market market in markets) {
      if (market.baseUnit == formattedTargetCurrency) {
        secondaryCurrencies.add(market.quoteUnit);
      }
      if (market.quoteUnit == formattedTargetCurrency) {
        secondaryCurrencies.add(market.baseUnit);
      }
    }

    var selectedSecondaryCurrency = '';
    outer:
    for (String secondaryCurrency in secondaryCurrencies) {
      for (Market market in markets) {
        if ((market.baseUnit == secondaryCurrency &&
                market.quoteUnit == formattedWalletCurrency) ||
            (market.quoteUnit == secondaryCurrency &&
                market.baseUnit == formattedWalletCurrency)) {
          selectedSecondaryCurrency = secondaryCurrency;
          break outer;
        }
      }
    }

    if (selectedSecondaryCurrency != '' && selectedSecondaryCurrency != null) {
      var secondaryCurrencyValue = estimateWithMarket(
          selectedSecondaryCurrency,
          formattedWalletCurrency,
          walletTotal,
          currencies,
          markets,
          marketTickers);

      return estimateWithMarket(targetCurrency, selectedSecondaryCurrency,
          secondaryCurrencyValue, currencies, markets, marketTickers);
    } else {
      // 'No secondary currency found for', wallet.currency
    }

    return 0.0;
  }

  static dynamic estimateValue(
      String targetCurrency,
      List<Currency> currencies,
      List<Wallet> wallets,
      List<Market> markets,
      Map<String, MarketTicker> marketTickers) {
    var formattedTargetCurrency = targetCurrency.toLowerCase();
    var estimatedValue = 0.0;

    if (wallets.length > 0) {
      for (Wallet wallet in wallets) {
        var formattedWalletCurrency = wallet.currency.toLowerCase();

        if (formattedWalletCurrency == formattedTargetCurrency) {
          var walletTotal =
              double.parse(wallet.balance) + double.parse(wallet.locked);
          estimatedValue += walletTotal;
        } else if (isMarketPresent(
            formattedTargetCurrency, formattedWalletCurrency, markets)) {
          estimatedValue += estimateWithMarket(
              formattedTargetCurrency,
              formattedWalletCurrency,
              getWalletTotal(wallet),
              currencies,
              markets,
              marketTickers);
        } else {
          estimatedValue += estimateWithoutMarket(
              formattedTargetCurrency,
              wallet.currency,
              getWalletTotal(wallet),
              currencies,
              markets,
              marketTickers);
        }
      }
    }

    var targetCurrencyPrecision = handleCCYPrecision(
        currencies, formattedTargetCurrency, defaultCCYPercision);
    var precisedEstimatedValue =
        double.parse(estimatedValue.toStringAsFixed(targetCurrencyPrecision));
    return precisedEstimatedValue;
  }

  static String estimateUnitValue(
      String targetCurrency,
      String currentCurrency,
      double total,
      List<Currency> currencies,
      List<Market> markets,
      Map<String, MarketTicker> marketTickers) {
    var estimated = 0.0;
    var estimatedWithMarket = estimateWithMarket(targetCurrency,
        currentCurrency, total, currencies, markets, marketTickers);
    var estimatedWithoutMarket = estimateWithoutMarket(targetCurrency,
        currentCurrency, total, currencies, markets, marketTickers);

    estimated = estimatedWithMarket > 0 ? estimatedWithMarket : 0;
    estimated = estimatedWithoutMarket > 0 ? estimatedWithoutMarket : 0;
    var formattedTargetCurrency = targetCurrency.toLowerCase();
    var targetCurrencyPrecision = handleCCYPrecision(
        currencies, formattedTargetCurrency, defaultCCYPercision);

    return estimated.toStringAsFixed(targetCurrencyPrecision);
  }
}
