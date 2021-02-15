import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/repository/trading_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/utils/Helpers/ws_helper.dart';
import 'package:crypto_template/models/wallet.dart';

class TradingController extends GetxController {
  TextEditingController limitOrderBuyPriceTextController;
  TextEditingController limitOrderBuyAmountTextController;
  TextEditingController limitOrderBuyTotalTextController;
  TextEditingController limitOrderSellAmountTextController;
  TextEditingController limitOrderSellPriceTextController;
  TextEditingController limitOrderSellTotalTextController;

  // GlobalKey<FormState> limitBuyformKey;
  // GlobalKey<FormState> limitSellformKey;

  TextEditingController marketOrderBuyPriceTextController;
  TextEditingController marketOrderBuyAmountTextController;
  TextEditingController marketOrderBuyTotalTextController;
  TextEditingController marketOrderSellAmountTextController;
  TextEditingController marketOrderSellPriceTextController;
  TextEditingController marketOrderSellTotalTextController;

  // GlobalKey<FormState> marketBuyformKey;
  // GlobalKey<FormState> marketSellformKey;

  var walletsList = List<Wallet>().obs;
  var walletBase = Wallet().obs;
  var walletQuote = Wallet().obs;

  var market = FormatedMarket().obs;
  MarketController marketController = Get.find();
  HomeController homeController = Get.find();
  WebSocketController webSocketController = Get.find();
  WalletController walletController;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  @override
  void onInit() async {
    limitOrderBuyPriceTextController = TextEditingController();
    limitOrderBuyAmountTextController = TextEditingController();
    limitOrderBuyTotalTextController = TextEditingController();
    limitOrderSellAmountTextController = TextEditingController();
    limitOrderSellPriceTextController = TextEditingController();
    limitOrderSellTotalTextController = TextEditingController();
    // limitBuyformKey = GlobalKey<FormState>();
    // limitSellformKey = GlobalKey<FormState>();

    marketOrderBuyPriceTextController = TextEditingController();
    marketOrderBuyAmountTextController = TextEditingController();
    marketOrderBuyTotalTextController = TextEditingController();
    marketOrderSellAmountTextController = TextEditingController();
    marketOrderSellPriceTextController = TextEditingController();
    marketOrderSellTotalTextController = TextEditingController();

    // marketBuyformKey = GlobalKey<FormState>();
    // marketSellformKey = GlobalKey<FormState>();

    market.value = marketController.selectedMarketTrading.value;
    if (homeController.isLoggedIn.value) {
      bool isWalletControllerRegistered = Get.isRegistered<WalletController>();

      walletController = isWalletControllerRegistered
          ? Get.find<WalletController>()
          : Get.put(WalletController());

      if (!walletController.isLoading.value &&
          walletController.walletsList.length > 0) {
        walletsList = walletController.walletsList;
        walletBase.value = getWallet(market.value.baseUnit, walletsList);
        walletQuote.value = getWallet(market.value.quoteUnit, walletsList);
      }
      ever(walletController.isLoading, setWalletValues);
    }

    super.onInit();
  }

  @override
  void onReady() {
    // marketController.orderBookSequence = -1;
    marketController.asks.clear();
    marketController.bids.clear();
    Future.delayed(Duration(seconds: 1), () {
      print('calling');
      webSocketController.subscribeOrderBookInc(market.value);
      getOrderBookDataFromWS();
    });

    super.onReady();
  }

  setWalletValues(isWalletsLoading) {
    if (!isWalletsLoading && walletController.walletsList.length > 0) {
      walletsList.assignAll(walletController.walletsList);
      if (homeController.isLoggedIn.value) {
        walletBase.value = getWallet(market.value.baseUnit, walletsList);
        walletQuote.value = getWallet(market.value.quoteUnit, walletsList);
      }
    }
  }

  Wallet getWallet(String currency, List<Wallet> wallets) {
    return wallets.firstWhere((wallet) {
      return wallet.name.toLowerCase().contains(currency.toLowerCase()) ||
          wallet.currency.toLowerCase().contains(currency.toLowerCase());
    });
  }

  void updateCurrentMarket(FormatedMarket newMarket) {
    webSocketController.unSubscribeOrderBookInc(market.value);
    market.value = newMarket;
    marketController.selectedMarketTrading.value = newMarket;
    webSocketController.subscribeOrderBookInc(newMarket);
    if (homeController.isLoggedIn.value) {
      walletBase.value = getWallet(market.value.baseUnit, walletsList);
      walletQuote.value = getWallet(market.value.quoteUnit, walletsList);
    }
  }

  void getOrderBookDataFromWS() {
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('${market.value.id}.ob-snap')) {
        marketController.asks
            .assignAll(data['${market.value.id}.ob-snap']['asks']);
        marketController.bids
            .assignAll(data['${market.value.id}.ob-snap']['bids']);
        marketController.orderBookSequence =
            data['${market.value.id}.ob-snap']['sequence'];
      }
      if (data.containsKey('${market.value.id}.ob-inc')) {
        var updatedAsksData = [];
        var updatedBidsData = [];
        if (marketController.orderBookSequence == -1) {
          print("OrderBook increment received before snapshot");
          return;
        }
        if (marketController.orderBookSequence + 1 !=
            data['${market.value.id}.ob-inc']['sequence']) {
          print(
              'Bad sequence detected in incremental orderbook previous: ${marketController.orderBookSequence}, event: ' +
                  data['${market.value.id}.ob-inc']['sequence'].toString());
          // emitter(rangerDisconnectFetch());

          return;
        }
        if (data['${market.value.id}.ob-inc']['asks'] != null) {
          var asks = data['${market.value.id}.ob-inc']['asks'];
          if (WsHelper.isArray(asks[0].toString())) {
            for (var i = 0; i < asks.length; i++) {
              updatedAsksData = WsHelper.handleIncrementalUpdate(
                  marketController.asks, asks[i], 'asks');
            }
          } else {
            updatedAsksData = WsHelper.handleIncrementalUpdate(
                marketController.asks, asks, 'asks');
          }

          updatedAsksData = updatedAsksData.length >= 10
              ? updatedAsksData.sublist(0, 10)
              : updatedAsksData;
          marketController.asks.assignAll(updatedAsksData);
          marketController.asks.refresh();
        }
        if (data['${market.value.id}.ob-inc']['bids'] != null) {
          var bids = data['${market.value.id}.ob-inc']['bids'];
          if (WsHelper.isArray(bids[0].toString())) {
            for (var i = 0; i < bids.length; i++) {
              updatedBidsData = WsHelper.handleIncrementalUpdate(
                  marketController.bids, bids[i], 'bids');
            }
          } else {
            updatedBidsData = WsHelper.handleIncrementalUpdate(
                marketController.bids, bids, 'bids');
          }
          updatedBidsData = updatedBidsData.length >= 10
              ? updatedBidsData.sublist(0, 10)
              : updatedBidsData;
          marketController.bids.assignAll(updatedBidsData);
          marketController.bids.refresh();
        }
        marketController.orderBookSequence =
            data['${market.value.id}.ob-inc']['sequence'];
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  void setBidFormPrice(List<dynamic> bid) {
    limitOrderBuyPriceTextController.text = bid[0];
    limitOrderSellPriceTextController.text = bid[0];
    marketOrderBuyPriceTextController.text = bid[0];
    marketOrderSellPriceTextController.text = bid[0];
  }

  void setAskFormPrice(List<dynamic> ask) {
    limitOrderBuyPriceTextController.text = ask[0];
    limitOrderSellPriceTextController.text = ask[0];
    marketOrderBuyPriceTextController.text = ask[0];
    marketOrderSellPriceTextController.text = ask[0];
  }

  void onLimitOrderBuyPriceChange(String value) {
    calculateLimitOrderBuyTotal();
  }

  void onLimitOrderBuyAmountChange(String value) {
    calculateLimitOrderBuyTotal();
  }

  void onLimitOrderBuyTotalChange(String value) {
    calculateLimitOrderBuyAmount();
  }

  void onLimitOrderSellPriceChange(String value) {
    calculateLimitOrderSellTotal();
  }

  void onLimitOrderSellAmountChange(String value) {
    calculateLimitOrderSellTotal();
  }

  void onLimitOrderSellTotalChange(String value) {
    calculateLimitOrderSellAmount();
  }

  //   void onLimitOrderBuyPriceChange(String value) {
  //   calculateLimitOrderBuyTotal();
  // }

  void onMarketOrderBuyAmountChange(String value) {
    calculateMarketOrderBuyTotal();
  }

  void onMarketOrderBuyTotalChange(String value) {
    calculateMarketOrderBuyAmount();
  }

  void onMarketOrderSellPriceChange(String value) {
    calculateMarketOrderSellTotal();
  }

  void onMarketOrderSellAmountChange(String value) {
    calculateMarketOrderSellTotal();
  }

  void onMarketOrderSellTotalChange(String value) {
    calculateMarketOrderSellAmount();
  }

  void calculateLimitOrderBuyTotal() {
    if (limitOrderBuyPriceTextController.text != '' &&
        limitOrderBuyAmountTextController.text != '') {
      double buyPrice = double.parse(limitOrderBuyPriceTextController.text);
      double buyAmount = double.parse(limitOrderBuyAmountTextController.text);
      double buyTotal = buyPrice * buyAmount;
      limitOrderBuyTotalTextController.text = buyTotal.toString();
    } else {
      limitOrderBuyTotalTextController.text = '';
    }
  }

  void calculateLimitOrderBuyAmount() {
    if (limitOrderBuyPriceTextController.text != '' &&
        limitOrderBuyTotalTextController.text != '') {
      double buyPrice = double.parse(limitOrderBuyPriceTextController.text);
      double buyTotal = double.parse(limitOrderBuyTotalTextController.text);
      double buyAmount = buyTotal / buyPrice;
      limitOrderBuyAmountTextController.text = buyAmount.toString();
    } else {
      limitOrderBuyAmountTextController.text = '';
    }
  }

  void calculateLimitOrderSellTotal() {
    if (limitOrderSellPriceTextController.text != '' &&
        limitOrderSellAmountTextController.text != '') {
      double sellPrice = double.parse(limitOrderSellPriceTextController.text);
      double sellAmount = double.parse(limitOrderSellAmountTextController.text);
      double sellTotal = sellPrice * sellAmount;
      limitOrderSellTotalTextController.text = sellTotal.toString();
    } else {
      limitOrderSellTotalTextController.text = '';
    }
  }

  void calculateLimitOrderSellAmount() {
    if (limitOrderSellPriceTextController.text != '' &&
        limitOrderSellTotalTextController.text != '') {
      double sellPrice = double.parse(limitOrderSellPriceTextController.text);
      double sellTotal = double.parse(limitOrderSellTotalTextController.text);
      double sellAmount = sellTotal / sellPrice;
      limitOrderSellAmountTextController.text = sellAmount.toString();
    } else {
      limitOrderSellAmountTextController.text = '';
    }
  }

  void calculateMarketOrderBuyTotal() {
    if (market.value.last > 0 &&
        marketOrderBuyAmountTextController.text != '') {
      double buyPrice = market.value.last;
      double buyAmount = double.parse(marketOrderBuyAmountTextController.text);
      double buyTotal = buyPrice * buyAmount;
      marketOrderBuyTotalTextController.text = buyTotal.toString();
    } else {
      marketOrderBuyTotalTextController.text = '';
    }
  }

  void calculateMarketOrderBuyAmount() {
    if (market.value.last > 0 && marketOrderBuyTotalTextController.text != '') {
      double buyPrice = market.value.last;
      double buyTotal = double.parse(marketOrderBuyTotalTextController.text);
      double buyAmount = buyTotal / buyPrice;
      marketOrderBuyAmountTextController.text = buyAmount.toString();
    } else {
      marketOrderBuyAmountTextController.text = '';
    }
  }

  void calculateMarketOrderSellTotal() {
    if (market.value.last > 0 &&
        marketOrderSellAmountTextController.text != '') {
      double sellPrice = market.value.last;
      double sellAmount =
          double.parse(marketOrderSellAmountTextController.text);
      double sellTotal = sellPrice * sellAmount;
      marketOrderSellTotalTextController.text = sellTotal.toString();
    } else {
      marketOrderSellTotalTextController.text = '';
    }
  }

  void calculateMarketOrderSellAmount() {
    if (market.value.last > 0 &&
        marketOrderSellTotalTextController.text != '') {
      double sellPrice = market.value.last;
      double sellTotal = double.parse(marketOrderSellTotalTextController.text);
      double sellAmount = sellTotal / sellPrice;
      marketOrderSellAmountTextController.text = sellAmount.toString();
    } else {
      marketOrderSellAmountTextController.text = '';
    }
  }

  void limitOrderBuy() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': limitOrderBuyAmountTextController.text,
        'market': market.value.id,
        'price': limitOrderBuyPriceTextController.text,
        'side': 'buy',
        'type': 'limit',
      };

      print(orderObj);
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void limitOrderSell() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': limitOrderSellAmountTextController.text,
        'market': market.value.id,
        'price': limitOrderSellPriceTextController.text,
        'side': 'sell',
        'type': 'limit',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created');
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void marketOrderBuy() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': marketOrderBuyAmountTextController.text,
        'market': market.value.id,
        'price': market.value.last,
        'side': 'buy',
        'type': 'limit',
      };

      print(orderObj);
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created');
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void marketOrderSell() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': marketOrderSellAmountTextController.text,
        'market': market.value.id,
        'price': market.value.last,
        'side': 'sell',
        'type': 'limit',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created');
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void marketBuyOrder() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': marketOrderSellAmountTextController.text,
        'market': market.value.id,
        'price': marketOrderSellPriceTextController.text,
        'side': 'buy',
        'type': 'market',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created');
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void marketSellOrder() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': marketOrderSellAmountTextController.text,
        'market': market.value.id,
        'price': marketOrderSellPriceTextController.text,
        'side': 'buy',
        'type': 'market',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created');
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    // limitOrderBuyPriceTextController?.dispose();
    // limitOrderBuyAmountTextController?.dispose();
    // limitOrderBuyTotalTextController?.dispose();
    // limitOrderSellPriceTextController?.dispose();
    // limitOrderSellAmountTextController?.dispose();
    // limitOrderSellTotalTextController?.dispose();

    // marketOrderBuyPriceTextController?.dispose();
    // marketOrderBuyAmountTextController?.dispose();
    // marketOrderBuyTotalTextController?.dispose();
    // marketOrderSellAmountTextController?.dispose();
    // marketOrderSellPriceTextController?.dispose();
    // marketOrderSellTotalTextController?.dispose();

    webSocketController.unSubscribeOrderBookInc(market.value);
    super.onClose();
  }
}
