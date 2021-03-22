import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/open_orders_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/trading_fee.dart';
import 'package:crypto_template/repository/trading_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/utils/Helpers/ws_helper.dart';
import 'package:crypto_template/models/wallet.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';

class TradingController extends GetxController {
  var limitBuyFormKey;
  var limitSellFormKey;
  var marketBuyFormKey;
  var marketSellFormKey;

  var limitBuyPriceFocusNode;
  var limitBuyAmountFocusNode;
  var limitBuyTotalFocusNode;
  var limitSellPriceFocusNode;
  var limitSellAmountFocusNode;
  var limitSellTotalFocusNode;

  var marketBuyAmountFocusNode;
  var marketBuyTotalFocusNode;
  var marketSellAmountFocusNode;
  var marketSellTotalFocusNode;

  var limitBuyFormPercentageOptions = List<FormPercentageOption>().obs;
  var limitSellFormPercentageOptions = List<FormPercentageOption>().obs;
  var marketBuyFormPercentageOptions = List<FormPercentageOption>().obs;
  var marketSellFormPercentageOptions = List<FormPercentageOption>().obs;

  var selectedLimitBuyFormPercentageOption = FormPercentageOption().obs;
  var selectedLimitSellFormPercentageOption = FormPercentageOption().obs;
  var selectedMarketBuyFormPercentageOption = FormPercentageOption().obs;
  var selectedMarketSellFormPercentageOption = FormPercentageOption().obs;

  TextEditingController limitOrderBuyPriceTextController;
  TextEditingController limitOrderBuyAmountTextController;
  TextEditingController limitOrderBuyTotalTextController;
  TextEditingController limitOrderSellAmountTextController;
  TextEditingController limitOrderSellPriceTextController;
  TextEditingController limitOrderSellTotalTextController;

  TextEditingController marketOrderBuyPriceTextController;
  TextEditingController marketOrderBuyAmountTextController;
  TextEditingController marketOrderBuyTotalTextController;
  TextEditingController marketOrderSellAmountTextController;
  TextEditingController marketOrderSellPriceTextController;
  TextEditingController marketOrderSellTotalTextController;

  var walletsList = List<Wallet>().obs;
  var walletBase = Wallet().obs;
  var walletQuote = Wallet().obs;
  var isLoadingTradingFee = false.obs;
  var tradingFeeList = List<TradingFee>().obs();
  var marketTradingFee = TradingFee().obs();

  var market = FormatedMarket().obs;
  MarketController marketController = Get.find();
  HomeController homeController = Get.find();
  WebSocketController webSocketController = Get.find();
  WalletController walletController;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  @override
  void onInit() async {
    limitBuyFormKey = GlobalKey<FormState>();
    limitSellFormKey = GlobalKey<FormState>();
    marketBuyFormKey = GlobalKey<FormState>();
    marketSellFormKey = GlobalKey<FormState>();

    limitBuyPriceFocusNode = FocusNode();
    limitBuyAmountFocusNode = FocusNode();
    limitBuyTotalFocusNode = FocusNode();
    limitSellPriceFocusNode = FocusNode();
    limitSellAmountFocusNode = FocusNode();
    limitSellTotalFocusNode = FocusNode();

    marketBuyAmountFocusNode = FocusNode();
    marketBuyTotalFocusNode = FocusNode();
    marketSellAmountFocusNode = FocusNode();
    marketSellTotalFocusNode = FocusNode();

    limitOrderBuyPriceTextController = TextEditingController();
    limitOrderBuyAmountTextController = TextEditingController();
    limitOrderBuyTotalTextController = TextEditingController();
    limitOrderSellAmountTextController = TextEditingController();
    limitOrderSellPriceTextController = TextEditingController();
    limitOrderSellTotalTextController = TextEditingController();

    marketOrderBuyPriceTextController = TextEditingController();
    marketOrderBuyAmountTextController = TextEditingController();
    marketOrderBuyTotalTextController = TextEditingController();
    marketOrderSellAmountTextController = TextEditingController();
    marketOrderSellPriceTextController = TextEditingController();
    marketOrderSellTotalTextController = TextEditingController();

    market.value = marketController.selectedMarketTrading.value;

    limitBuyFormPercentageOptions.assignAll([
      FormPercentageOption(id: 1, value: 25, name: "25%", isActive: false),
      FormPercentageOption(id: 2, value: 50, name: "50%", isActive: false),
      FormPercentageOption(id: 3, value: 75, name: "75%", isActive: false),
      FormPercentageOption(id: 4, value: 100, name: "100%", isActive: false),
    ]);

    limitSellFormPercentageOptions.assignAll([
      FormPercentageOption(id: 1, value: 25, name: "25%", isActive: false),
      FormPercentageOption(id: 2, value: 50, name: "50%", isActive: false),
      FormPercentageOption(id: 3, value: 75, name: "75%", isActive: false),
      FormPercentageOption(id: 4, value: 100, name: "100%", isActive: false),
    ]);
    marketBuyFormPercentageOptions.assignAll([
      FormPercentageOption(id: 1, value: 25, name: "25%", isActive: false),
      FormPercentageOption(id: 2, value: 50, name: "50%", isActive: false),
      FormPercentageOption(id: 3, value: 75, name: "75%", isActive: false),
      FormPercentageOption(id: 4, value: 100, name: "100%", isActive: false),
    ]);
    marketSellFormPercentageOptions.assignAll([
      FormPercentageOption(id: 1, value: 25, name: "25%", isActive: false),
      FormPercentageOption(id: 2, value: 50, name: "50%", isActive: false),
      FormPercentageOption(id: 3, value: 75, name: "75%", isActive: false),
      FormPercentageOption(id: 4, value: 100, name: "100%", isActive: false),
    ]);
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
      fetchTradingFee();
      ever(walletController.isLoading, setWalletValues);
    }
    ever(homeController.isLoggedIn, setWalletValuesAfterLogin);
    super.onInit();
  }

  @override
  void onReady() {
    marketController.asks.clear();
    marketController.bids.clear();
    Future.delayed(Duration(seconds: 1), () {
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

  setWalletValuesAfterLogin(isUserLoggedIn) {
    if (isUserLoggedIn) {
      bool isWalletControllerRegistered = Get.isRegistered<WalletController>();

      walletController = isWalletControllerRegistered
          ? Get.find<WalletController>()
          : Get.put(WalletController());
      fetchTradingFee();
      ever(walletController.isLoading, setWalletValues);
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

  void fetchTradingFee() async {
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      isLoadingTradingFee(true);
      var tradingFee = await _tradingRepository.fetchTradingFee();
      marketTradingFee = tradingFee;
      // if (tradingFeeList.length > 0 && homeController.isLoggedIn.value) {
      //   var marketFee = tradingFeeList.firstWhere((TradingFee tradingFee) {
      //     return (tradingFee.group == homeController.user.value.feeGroup);
      //   });
      //   marketTradingFee = marketFee;
      //   isLoadingTradingFee(false);
      // }
    } catch (error) {
      print(error);
      isLoadingTradingFee(false);
      errorController.handleError(error);
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

        marketController.maxVolume.value =
            Helper.calcMaxVolume(marketController.bids, marketController.asks);
        marketController.orderBookEntryBids
            .assignAll(Helper.accumulateVolume(marketController.bids));
        marketController.orderBookEntryAsks
            .assignAll(Helper.accumulateVolume(marketController.asks));
      }
      if (data.containsKey('${market.value.id}.ob-inc')) {
        var updatedAsksData = [];
        var updatedBidsData = [];
        if (marketController.orderBookSequence == -1) {
          // print("OrderBook increment received before snapshot");
          return;
        }
        if (marketController.orderBookSequence + 1 !=
            data['${market.value.id}.ob-inc']['sequence']) {
          // print(
          //     'Bad sequence detected in incremental orderbook previous: ${marketController.orderBookSequence}, event: ' +
          //         data['${market.value.id}.ob-inc']['sequence'].toString());
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

          marketController.maxVolume.value =
              Helper.calcMaxVolume(marketController.bids, updatedAsksData);
          marketController.orderBookEntryBids
              .assignAll(Helper.accumulateVolume(marketController.bids));
          marketController.orderBookEntryAsks
              .assignAll(Helper.accumulateVolume(updatedAsksData));
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

          marketController.maxVolume.value =
              Helper.calcMaxVolume(updatedBidsData, marketController.asks);
          marketController.orderBookEntryBids
              .assignAll(Helper.accumulateVolume(updatedBidsData));
          marketController.orderBookEntryAsks
              .assignAll(Helper.accumulateVolume(marketController.asks));
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
    // marketOrderBuyPriceTextController.text = bid[0];
    // marketOrderSellPriceTextController.text = bid[0];
    onLimitOrderBuyPriceChange(limitOrderBuyPriceTextController.text);
    onLimitOrderSellPriceChange(limitOrderSellPriceTextController.text);
  }

  void setAskFormPrice(List<dynamic> ask) {
    limitOrderBuyPriceTextController.text = ask[0];
    limitOrderSellPriceTextController.text = ask[0];
    // marketOrderBuyPriceTextController.text = ask[0];
    // marketOrderSellPriceTextController.text = ask[0];
    onLimitOrderBuyPriceChange(limitOrderBuyPriceTextController.text);
    onLimitOrderSellPriceChange(limitOrderSellPriceTextController.text);
  }

  void onLimitOrderBuyPriceChange(String value) {
    calculateLimitOrderBuyTotal();
    resetLimitBuyOrderPercentageButtons();
  }

  void onLimitOrderBuyAmountChange(String value) {
    calculateLimitOrderBuyTotal();
    resetLimitBuyOrderPercentageButtons();
  }

  void onLimitOrderBuyTotalChange(String value) {
    calculateLimitOrderBuyAmount();
    resetLimitBuyOrderPercentageButtons();
  }

  void onLimitOrderSellPriceChange(String value) {
    calculateLimitOrderSellTotal();
    resetLimitSellOrderPercentageButtons();
  }

  void onLimitOrderSellAmountChange(String value) {
    calculateLimitOrderSellTotal();
    resetLimitSellOrderPercentageButtons();
  }

  void onLimitOrderSellTotalChange(String value) {
    calculateLimitOrderSellAmount();
    resetLimitSellOrderPercentageButtons();
  }

  //   void onLimitOrderBuyPriceChange(String value) {
  //   calculateLimitOrderBuyTotal();
  // }

  void onMarketOrderBuyAmountChange(String value) {
    calculateMarketOrderBuyTotal();
    resetMarketBuyOrderPercentageButtons();
  }

  void onMarketOrderBuyTotalChange(String value) {
    calculateMarketOrderBuyAmount();
    resetMarketBuyOrderPercentageButtons();
  }

  // void onMarketOrderSellPriceChange(String value) {
  //   calculateMarketOrderSellTotal();
  // }

  void onMarketOrderSellAmountChange(String value) {
    calculateMarketOrderSellTotal();
    resetMarketSellOrderPercentageButtons();
  }

  void onMarketOrderSellTotalChange(String value) {
    calculateMarketOrderSellAmount();
    resetMarketSellOrderPercentageButtons();
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

  void percentageOptionClick(
      String tab, String form, FormPercentageOption percentageOption) {
    if (tab == 'limit') {
      if (form == 'buy') {
        for (FormPercentageOption option in limitBuyFormPercentageOptions) {
          if (!percentageOption.isActive ||
              selectedLimitBuyFormPercentageOption.value.value !=
                  percentageOption.value) {
            if (option.value <= percentageOption.value) {
              option.isActive = true;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          } else {
            if (option.value <= percentageOption.value) {
              option.isActive = false;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          }
        }
        selectedLimitBuyFormPercentageOption.value = percentageOption;
        limitBuyFormPercentageOptions.refresh();
        if (homeController.isLoggedIn.value) {
          if (selectedLimitBuyFormPercentageOption.value.isActive) {
            limitOrderBuyTotalTextController.text =
                getWalletBalanceByPercentage(
                    walletQuote.value,
                    selectedLimitBuyFormPercentageOption.value.value,
                    double.parse(marketTradingFee.taker));
          } else {
            limitOrderBuyTotalTextController.text = '';
          }
          calculateLimitOrderBuyAmount();
        }
      } else {
        for (FormPercentageOption option in limitSellFormPercentageOptions) {
          if (!percentageOption.isActive ||
              selectedLimitSellFormPercentageOption.value.value !=
                  percentageOption.value) {
            if (option.value <= percentageOption.value) {
              option.isActive = true;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          } else {
            if (option.value <= percentageOption.value) {
              option.isActive = false;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          }
        }
        selectedLimitSellFormPercentageOption.value = percentageOption;
        limitSellFormPercentageOptions.refresh();
        if (homeController.isLoggedIn.value) {
          if (selectedLimitSellFormPercentageOption.value.isActive) {
            limitOrderSellTotalTextController.text =
                getWalletBalanceByPercentage(
                    walletBase.value,
                    selectedLimitSellFormPercentageOption.value.value,
                    double.parse(marketTradingFee.maker));
          } else {
            limitOrderSellTotalTextController.text = '';
          }
          calculateLimitOrderSellAmount();
        }
      }
    } else {
      if (form == 'buy') {
        for (FormPercentageOption option in marketBuyFormPercentageOptions) {
          if (!percentageOption.isActive ||
              selectedMarketBuyFormPercentageOption.value.value !=
                  percentageOption.value) {
            if (option.value <= percentageOption.value) {
              option.isActive = true;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          } else {
            if (option.value <= percentageOption.value) {
              option.isActive = false;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          }
        }
        selectedMarketBuyFormPercentageOption.value = percentageOption;
        marketBuyFormPercentageOptions.refresh();
        if (homeController.isLoggedIn.value) {
          if (selectedMarketBuyFormPercentageOption.value.isActive) {
            marketOrderBuyTotalTextController.text =
                getWalletBalanceByPercentage(
                    walletQuote.value,
                    selectedMarketBuyFormPercentageOption.value.value,
                    double.parse(marketTradingFee.taker));
          } else {
            marketOrderBuyTotalTextController.text = '';
          }
          calculateMarketOrderBuyAmount();
        }
      } else {
        for (FormPercentageOption option in marketSellFormPercentageOptions) {
          if (!percentageOption.isActive ||
              selectedMarketSellFormPercentageOption.value.value !=
                  percentageOption.value) {
            if (option.value <= percentageOption.value) {
              option.isActive = true;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          } else {
            if (option.value <= percentageOption.value) {
              option.isActive = false;
            } else if (option.value > percentageOption.value) {
              option.isActive = false;
            }
          }
        }
        selectedMarketSellFormPercentageOption.value = percentageOption;
        marketSellFormPercentageOptions.refresh();
        if (homeController.isLoggedIn.value) {
          if (selectedMarketSellFormPercentageOption.value.isActive) {
            marketOrderSellTotalTextController.text =
                getWalletBalanceByPercentage(
                    walletQuote.value,
                    selectedMarketSellFormPercentageOption.value.value,
                    double.parse(marketTradingFee.taker));
          } else {
            marketOrderSellTotalTextController.text = '';
          }
          calculateMarketOrderSellAmount();
        }
      }
    }
  }

  String getWalletBalanceByPercentage(
      Wallet wallet, int percentage, double tradingFeePercentage) {
    var percentageValue = '';
    if (percentage != 100) {
      percentageValue =
          ((percentage / 100) * double.parse(wallet.balance)).toString();
    } else {
      var percentageValue1 =
          ((percentage / 100) * double.parse(wallet.balance));
      var marketFeePercentage = (tradingFeePercentage / 100) * percentageValue1;

      percentageValue = (percentageValue1 - marketFeePercentage).toString();
    }
    return percentageValue;
  }

  void resetLimitBuyOrderPercentageButtons() {
    for (FormPercentageOption option in limitBuyFormPercentageOptions) {
      option.isActive = false;
    }
    limitBuyFormPercentageOptions.refresh();
  }

  void resetLimitSellOrderPercentageButtons() {
    for (FormPercentageOption option in limitSellFormPercentageOptions) {
      option.isActive = false;
    }
    limitSellFormPercentageOptions.refresh();
  }

  void resetMarketBuyOrderPercentageButtons() {
    for (FormPercentageOption option in marketBuyFormPercentageOptions) {
      option.isActive = false;
    }
    marketBuyFormPercentageOptions.refresh();
  }

  void resetMarketSellOrderPercentageButtons() {
    for (FormPercentageOption option in marketSellFormPercentageOptions) {
      option.isActive = false;
    }
    marketSellFormPercentageOptions.refresh();
  }

  void limitOrderBuy() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'volume': limitOrderBuyAmountTextController.text,
        'market': market.value.id,
        'price': limitOrderBuyPriceTextController.text,
        'side': 'buy',
        'ord_type': 'limit',
      };

      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      OpenOrdersController openOrdersController = Get.find();
      openOrdersController.openOrdersList.insert(0, orderResponseResponse);
      openOrdersController.openOrdersList.refresh();
      openOrdersController.openOrdersSortedList
          .insert(0, orderResponseResponse);
      openOrdersController.openOrdersSortedList.refresh();
      Get.back();
      resetLimitOrderForm();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created'.tr);
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
        'volume': limitOrderSellAmountTextController.text,
        'market': market.value.id,
        'price': limitOrderSellPriceTextController.text,
        'side': 'sell',
        'ord_type': 'limit',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      OpenOrdersController openOrdersController = Get.find();
      openOrdersController.openOrdersList.insert(0, orderResponseResponse);
      openOrdersController.openOrdersList.refresh();
      openOrdersController.openOrdersSortedList
          .insert(0, orderResponseResponse);
      openOrdersController.openOrdersSortedList.refresh();
      Get.back();
      resetLimitOrderForm();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created'.tr);
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void resetLimitOrderForm() {
    limitOrderBuyPriceTextController.text = '';
    limitOrderBuyAmountTextController.text = '';
    limitOrderBuyTotalTextController.text = '';
    limitOrderSellAmountTextController.text = '';
    limitOrderSellPriceTextController.text = '';
    limitOrderSellTotalTextController.text = '';
  }

  void resetMarketOrderForm() {
    marketOrderBuyPriceTextController.text = '';
    marketOrderBuyAmountTextController.text = '';
    marketOrderBuyTotalTextController.text = '';
    marketOrderSellAmountTextController.text = '';
    marketOrderSellPriceTextController.text = '';
    marketOrderSellTotalTextController.text = '';
  }

  void marketOrderBuy() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    TradingRepository _tradingRepository = new TradingRepository();
    try {
      var orderObj = {
        'volume': marketOrderBuyAmountTextController.text,
        'market': market.value.id,
        'side': 'buy',
        'ord_type': 'market',
      };

      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      OpenOrdersController openOrdersController = Get.find();
      openOrdersController.openOrdersList.insert(0, orderResponseResponse);
      openOrdersController.openOrdersList.refresh();
      openOrdersController.openOrdersSortedList
          .insert(0, orderResponseResponse);
      openOrdersController.openOrdersSortedList.refresh();
      Get.back();
      resetMarketOrderForm();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created'.tr);
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
        'volume': marketOrderSellAmountTextController.text,
        'market': market.value.id,
        'side': 'sell',
        'ord_type': 'market',
      };
      var orderResponseResponse =
          await _tradingRepository.placeTradingOrder(orderObj);
      OpenOrdersController openOrdersController = Get.find();
      openOrdersController.openOrdersList.insert(0, orderResponseResponse);
      openOrdersController.openOrdersList.refresh();
      openOrdersController.openOrdersSortedList
          .insert(0, orderResponseResponse);
      openOrdersController.openOrdersSortedList.refresh();
      Get.back();
      resetMarketOrderForm();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.order.created'.tr);
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    // limitBuyPriceFocusNode.dispose();
    // limitBuyAmountFocusNode.dispose();
    // limitBuyTotalFocusNode.dispose();
    // limitSellPriceFocusNode.dispose();
    // limitSellAmountFocusNode.dispose();
    // limitSellTotalFocusNode.dispose();

    // marketBuyAmountFocusNode.dispose();
    // marketBuyTotalFocusNode.dispose();
    // marketSellAmountFocusNode.dispose();
    // marketSellTotalFocusNode.dispose();

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

    bool openOrdersControllerRegistered =
        Get.isRegistered<OpenOrdersController>();
    bool isWalletControllerRegistered = Get.isRegistered<WalletController>();
    if (openOrdersControllerRegistered) {
      Get.delete<OpenOrdersController>(force: true);
    }
    if (isWalletControllerRegistered) {
      Get.delete<WalletController>(force: true);
    }

    webSocketController.unSubscribeOrderBookInc(market.value);
    super.onClose();
  }
}

List<FormPercentageOption> formPercentageOptionFromJson(String str) =>
    List<FormPercentageOption>.from(
        json.decode(str).map((x) => FormPercentageOption.fromJson(x)));

String formPercentageOptionToJson(List<FormPercentageOption> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FormPercentageOption {
  FormPercentageOption({
    this.id,
    this.value,
    this.name,
    this.isActive,
  });

  int id;
  int value;
  String name;
  bool isActive;

  factory FormPercentageOption.fromJson(Map<String, dynamic> json) =>
      FormPercentageOption(
        id: json["id"],
        value: json["value"],
        name: json["name"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "name": name,
        "isActive": isActive,
      };
}
