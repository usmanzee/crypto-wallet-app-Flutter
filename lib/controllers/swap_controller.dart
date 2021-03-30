import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/models/formated_market.dart';
import 'package:b4u_wallet/models/wallet.dart';
import 'package:b4u_wallet/repository/swap_repository.dart';
import 'package:b4u_wallet/repository/trading_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapController extends GetxController {
  TextEditingController fromAmountTextController;
  TextEditingController toAmountTextController;
  TextEditingController otpCodeTextController;

  var isLoading = false.obs;
  var isLoadingExchangeRate = false.obs;
  var amount = '0.0'.obs;
  var totalWithdrawlAmount = 0.0.obs;
  var withdrawingCrypto = false.obs;
  var walletsList = <Wallet>[].obs;
  var searchWalletsList = <Wallet>[].obs;
  var fromWalletsList = <Wallet>[].obs;
  var toWalletsList = <Wallet>[].obs;
  var fromSelectedWallet = Wallet().obs;
  var toSelectedWallet = Wallet().obs;
  var selectedWalletIndex = 0.obs;
  var _fromFieldError = false.obs;
  var fromFieldErrorText = ''.obs;
  var exchangeRate = ''.obs;
  var receivableAmount = ''.obs;

  var fromFieldfocus = FocusNode().obs;
  var toFieldfocus = FocusNode().obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find();
  // final SwapController swapController = Get.put(SwapController());
  final WalletController walletController = Get.put(WalletController());
  // final WalletController walletController = Get.find();
  final MarketController marketController = Get.find();

  // get selectedWalletIndex => this._selectedWalletIndex.value;
  // set selectedWalletIndex(index) => this._selectedWalletIndex.value = index;

  get fromFieldError => this._fromFieldError.value;
  set fromFieldError(value) => this._fromFieldError.value = value;

  @override
  void onInit() async {
    isLoading(true);
    fromAmountTextController = TextEditingController();
    toAmountTextController = TextEditingController();
    otpCodeTextController = TextEditingController();
    homeController.fetchUser();
    homeController.fetchMemberLevels();
    if (!walletController.isLoading.value) {
      walletsList.assignAll(walletController.walletsList);
      // await matchWalletsWithMarkets();
      searchWalletsList.assignAll(walletsList);
      await assignFromWallets(searchWalletsList);
      var newList = await matchWalletsWithSelectedFromCurrency();
      await assignToWallets(newList);
      isLoading(false);
    }
    ever(walletController.isLoading, setWalletValues);
    super.onInit();
  }

  Future<List<Wallet>> matchWalletsWithSelectedFromCurrency() async {
    List<Wallet> newList = [];

    List<FormatedMarket> marketsList =
        marketController.formatedMarketsList.where((formatedMarket) {
      return fromSelectedWallet.value.currency.toLowerCase() ==
              formatedMarket.baseUnit.toLowerCase() ||
          fromSelectedWallet.value.currency.toLowerCase() ==
              formatedMarket.quoteUnit.toLowerCase();
    }).toList();
    List<String> currencies = [];
    for (FormatedMarket market in marketsList) {
      if (market.baseUnit.toLowerCase() !=
          fromSelectedWallet.value.currency.toLowerCase()) {
        currencies.add(market.baseUnit.toLowerCase());
      }
      if (market.quoteUnit.toLowerCase() !=
          fromSelectedWallet.value.currency.toLowerCase()) {
        currencies.add(market.quoteUnit.toLowerCase());
      }
    }
    newList = walletsList.where((Wallet wallet) {
      return currencies.contains(wallet.currency.toLowerCase());
    }).toList();
    if (fromSelectedWallet.value.type == 'fiat') {
      var fiatWalletsList = walletsList.where((Wallet wallet) {
        return wallet.type == 'fiat' &&
            fromSelectedWallet.value.currency.toLowerCase() !=
                wallet.currency.toLowerCase() &&
            !checkIfWalletExistsInWallets(wallet, newList);
      });
      newList.addAll(fiatWalletsList);
    }
    return newList;
  }

  bool checkIfWalletExistsInWallets(Wallet wallet, List<Wallet> wallets) {
    var walletExists = wallets.firstWhere(
        (walletItem) =>
            walletItem.currency.toLowerCase() == wallet.currency.toLowerCase(),
        orElse: () => null);

    return walletExists != null ? true : false;
  }

  setWalletValues(isWalletsLoading) async {
    if (!isWalletsLoading && walletController.walletsList.length > 0) {
      walletsList.assignAll(walletController.walletsList);
      // await matchWalletsWithMarkets();
      searchWalletsList.assignAll(walletsList);
      await assignFromWallets(searchWalletsList);
      var newList = await matchWalletsWithSelectedFromCurrency();
      await assignToWallets(newList);
      isLoading(false);
    }
  }

  Future<void> assignFromWallets(List<Wallet> wallets) async {
    fromWalletsList.assignAll(wallets);
    if (wallets.length > 0) {
      fromSelectedWallet.value = wallets[0];
    }
  }

  Future<void> assignToWallets(List<Wallet> wallets) async {
    fromWalletsList.assignAll(wallets);
    toSelectedWallet.value = wallets.length > 0 ? wallets[0] : null;
  }

  Future<void> matchWalletsWithMarkets() async {
    walletsList.removeWhere((Wallet wallet) {
      FormatedMarket marketExists = marketController.formatedMarketsList
          .firstWhere(
              (market) => (wallet.currency.toLowerCase() ==
                      market.baseUnit.toLowerCase() ||
                  wallet.currency.toLowerCase() ==
                      market.quoteUnit.toLowerCase()),
              orElse: () => null);
      return marketExists != null ? false : true;
    });
    searchWalletsList.assignAll(walletsList);
  }

  void setWalletOnClick(wallet) async {
    if (selectedWalletIndex.value == 0) {
      fromSelectedWallet.value = wallet;

      var newList = await matchWalletsWithSelectedFromCurrency();
      await assignToWallets(newList);
      searchWalletsList.assignAll(newList);

      fromAmountTextController.text = '';
      fromFieldErrorText.value = '';
      fromFieldError = false;
      selectedWalletIndex.value = 1;
    } else {
      toSelectedWallet.value = wallet;
      fromAmountTextController.text = '';
      fromFieldErrorText.value = '';
      fromFieldError = false;
    }
  }

  void setSearchWallets() async {
    if (selectedWalletIndex.value == 0) {
      searchWalletsList.assignAll(walletsList);
    } else {
      var newList = await matchWalletsWithSelectedFromCurrency();
      searchWalletsList.assignAll(newList);
    }
  }

  void setFromSelectedWallet(wallet) {
    if (toSelectedWallet.value.currency.toLowerCase() ==
        wallet.currency.toLowerCase()) {
      toSelectedWallet.value = fromSelectedWallet.value;
    }
    fromSelectedWallet.value = wallet;
    fromAmountTextController.text = '';
    fromFieldErrorText.value = '';
    fromFieldError = false;
  }

  void setToSelectedWallet(wallet) {
    if (fromSelectedWallet.value.currency.toLowerCase() ==
        wallet.currency.toLowerCase()) {
      fromSelectedWallet.value = toSelectedWallet.value;
    }
    toSelectedWallet.value = wallet;
    fromAmountTextController.text = '';
    fromFieldErrorText.value = '';
    fromFieldError = false;
  }

  void handleSearchInputChangeEvent(String value) {
    if (selectedWalletIndex.value == 0) {
      var searchedList = fromWalletsList.where((wallet) {
        return wallet.name.toLowerCase().contains(value.toLowerCase()) ||
            wallet.currency.toLowerCase().contains(value.toLowerCase());
      });
      searchWalletsList.assignAll(searchedList);
    } else {
      var searchedList = toWalletsList.where((wallet) {
        return wallet.name.toLowerCase().contains(value.toLowerCase()) ||
            wallet.currency.toLowerCase().contains(value.toLowerCase());
      });
      searchWalletsList.assignAll(searchedList);
    }
  }

  void handleFromFieldErrror() {
    var amount = fromAmountTextController.text;
    var minSwapAmount = double.parse(fromSelectedWallet.value.minSwapAmount);
    var maxSwapAmount = double.parse(fromSelectedWallet.value.maxSwapAmount);
    var currency = fromSelectedWallet.value.currency.toUpperCase();
    if (amount != '') {
      double receivedAmount = double.parse(amount);
      if (receivedAmount < minSwapAmount) {
        fromFieldError = true;
        fromFieldErrorText.value = 'swap.screen.amount.error1'.trParams(
            {'amount': minSwapAmount.toString(), 'currency': currency});
      } else if (receivedAmount > maxSwapAmount) {
        fromFieldError = true;

        fromFieldErrorText.value = 'swap.screen.amount.error2'.trParams(
            {'amount': maxSwapAmount.toString(), 'currency': currency});
      } else if (receivedAmount >
          double.parse(fromSelectedWallet.value.balance)) {
        fromFieldError = true;
        fromFieldErrorText.value = 'swap.screen.amount.error3'.tr;
      } else {
        fromFieldError = false;
        fromFieldErrorText.value = '';
      }
    } else {
      fromFieldError = false;
      fromFieldErrorText.value = '';
    }
  }

  void fetchExchangeRate() async {
    SwapRepository _swapRepository = new SwapRepository();
    try {
      isLoadingExchangeRate(true);
      var exchangeRateRequestObj = {
        'base_currency': toSelectedWallet.value.currency,
        'qoute_currency': fromSelectedWallet.value.currency,
        'qoute_amount': fromAmountTextController.text
      };
      var exchangeRateResponse =
          await _swapRepository.fetchExchangeRate(exchangeRateRequestObj);

      var exchangeRateRes = double.parse(exchangeRateResponse);
      var rate = exchangeRateRes / double.parse(fromAmountTextController.text);
      exchangeRate.value = rate.toString();

      var receivable = exchangeRateRes -
          (exchangeRateRes * double.parse(toSelectedWallet.value.swapFee));
      receivableAmount.value = receivable.toString();

      isLoadingExchangeRate(false);
    } catch (error) {
      isLoadingExchangeRate(false);
      errorController.handleError(error);
    }
  }

  void exchangeRequest() async {
    SwapRepository _swapRepository = new SwapRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      if (fromSelectedWallet.value.type == 'fiat' &&
          toSelectedWallet.value.type == 'fiat') {
        var exchangeRequestObj = {
          'base_currency': toSelectedWallet.value.currency,
          'qoute_currency': fromSelectedWallet.value.currency,
          'qoute_amount': fromAmountTextController.text,
          'otp': otpCodeTextController.text
        };
        await _swapRepository.exchangeRequest(exchangeRequestObj);
      } else {
        TradingRepository _tradingRepository = new TradingRepository();
        String orderSide = 'sell';
        FormatedMarket existingMarket;
        String fromCurrency = fromSelectedWallet.value.currency.toLowerCase();
        String toCurrency = toSelectedWallet.value.currency.toLowerCase();

        existingMarket = marketController.formatedMarketsList.firstWhere(
            (market) =>
                market.baseUnit.toLowerCase() == fromCurrency &&
                market.quoteUnit.toLowerCase() == toCurrency,
            orElse: () => null);

        if (existingMarket == null) {
          orderSide = 'buy';
          existingMarket = marketController.formatedMarketsList.firstWhere(
              (market) =>
                  market.quoteUnit.toLowerCase() == fromCurrency &&
                  market.baseUnit.toLowerCase() == toCurrency,
              orElse: () => null);
        }
        var orderObj = {
          'volume': fromAmountTextController.text,
          'market': existingMarket.id,
          'price': existingMarket.last.toString(),
          'side': orderSide,
          'ord_type': 'limit'
        };
        await _tradingRepository.placeTradingOrder(orderObj);
      }
      resetSwapForm();
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'account.exchanges.exchange.success'.tr);
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void resetSwapForm() {
    fromAmountTextController.clear();
    toAmountTextController.clear();
    otpCodeTextController.clear();
  }

  @override
  void onClose() {
    bool isWalletControllerRegistered = Get.isRegistered<WalletController>();
    if (isWalletControllerRegistered) {
      Get.delete<WalletController>(force: true);
    }
    // fromFieldfocus.value.dispose();
    // toFieldfocus.value.dispose();
    // fromAmountTextController?.dispose();
    // toAmountTextController?.dispose();
    // otpCodeTextController?.dispose();
    super.onClose();
  }
}
