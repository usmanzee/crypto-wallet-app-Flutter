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

  var market = FormatedMarket().obs;
  MarketController marketController = Get.find();
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

    bool isWalletControllerRegistered = Get.isRegistered<WalletController>();

    walletController = isWalletControllerRegistered
        ? Get.find<WalletController>()
        : Get.put(WalletController());

    if (!walletController.isLoading.value) {
      walletsList = walletController.walletsList;
    }
    ever(walletController.isLoading, setWalletValues);

    super.onInit();
    print('onint trading');
  }

  @override
  void onReady() {
    print('ready trading');
    super.onReady();
    // webSocketController.subscribeOrderBookInc(market.value);
    // getOrderBookDataFromWS();
  }

  setWalletValues(isWalletsLoading) {
    print(!isWalletsLoading && walletController.walletsList.length > 0);
    if (!isWalletsLoading && walletController.walletsList.length > 0) {
      walletsList.assignAll(walletController.walletsList);
    }
  }

  void updateCurrentMarket(FormatedMarket newMarket) {
    webSocketController.unSubscribeOrderBookInc(market.value);
    market.value = newMarket;
    marketController.selectedMarketTrading.value = newMarket;
    webSocketController.subscribeOrderBookInc(newMarket);
  }

  void getOrderBookDataFromWS() {
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('${market.value.id}.ob-snap')) {
        marketController.asks
            .assignAll(data['${market.value.id}.ob-snap']['asks']);
        marketController.bids
            .assignAll(data['${market.value.id}.ob-snap']['bids']);
      }
      if (data.containsKey('${market.value.id}.ob-inc')) {
        // print(data);
        var updatedAsksData = [];
        var updatedBidsData = [];
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
          // makeDepthData();
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
          // makeDepthData();
        }
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  void limitBuyOrder() async {
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'amount': limitOrderBuyAmountTextController.text,
        'market': market.value.id,
        'price': limitOrderBuyPriceTextController.text,
        'side': 'buy',
        'type': 'limit',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      print(orderResponseResponse);
    } catch (error) {
      errorController.handleError(error);
    }
  }

  void limitSellOrder() async {
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
    } catch (error) {
      errorController.handleError(error);
    }
  }

  void marketBuyOrder() async {
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
    } catch (error) {
      errorController.handleError(error);
    }
  }

  void marketSellOrder() async {
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
    } catch (error) {
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    limitOrderBuyPriceTextController?.dispose();
    limitOrderBuyAmountTextController?.dispose();
    limitOrderBuyTotalTextController?.dispose();
    limitOrderSellPriceTextController?.dispose();
    limitOrderSellAmountTextController?.dispose();
    limitOrderSellTotalTextController?.dispose();

    marketOrderBuyPriceTextController?.dispose();
    marketOrderBuyAmountTextController?.dispose();
    marketOrderBuyTotalTextController?.dispose();
    marketOrderSellAmountTextController?.dispose();
    marketOrderSellPriceTextController?.dispose();
    marketOrderSellTotalTextController?.dispose();

    webSocketController.unSubscribeOrderBookInc(market.value);
    super.onClose();
  }
}
