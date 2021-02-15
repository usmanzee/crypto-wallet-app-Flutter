import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/models/wallet.dart';
import 'package:crypto_template/repository/swap_repository.dart';
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
  var fromWalletsList = List<Wallet>().obs;
  var toWalletsList = List<Wallet>().obs;
  var fromSelectedWallet = Wallet().obs;
  var toSelectedWallet = Wallet().obs;
  var _selectedWalletIndex = 0.obs;
  var _fromFieldError = false.obs;
  var fromFieldErrorText = ''.obs;
  var exchangeRate = ''.obs;
  var receivableAmount = ''.obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find();
  final WalletController walletController = Get.find();

  get selectedWalletIndex => this._selectedWalletIndex.value;
  set selectedWalletIndex(index) => this._selectedWalletIndex.value = index;

  get fromFieldError => this._fromFieldError.value;
  set fromFieldError(value) => this._fromFieldError.value = value;

  @override
  void onInit() {
    isLoading(true);
    fromAmountTextController = TextEditingController();
    toAmountTextController = TextEditingController();
    otpCodeTextController = TextEditingController();
    homeController.fetchUser();
    homeController.fetchMemberLevels();
    if (!walletController.isLoading.value) {
      isLoading(false);
      fromWalletsList = walletController.walletsList;
      toWalletsList = walletController.walletsList;
      fromSelectedWallet.value = walletController.walletsList[0];
      toSelectedWallet.value = walletController.walletsList[1];
    }
    ever(walletController.isLoading, setWalletValues);
    super.onInit();
  }

  setWalletValues(isWalletsLoading) {
    print(!isWalletsLoading && walletController.walletsList.length > 0);
    if (!isWalletsLoading && walletController.walletsList.length > 0) {
      isLoading(false);
      fromWalletsList.assignAll(walletController.walletsList);
      toWalletsList.assignAll(walletController.walletsList);
      if (walletController.walletsList.length > 0) {
        fromSelectedWallet.value = walletController.walletsList[0];
        toSelectedWallet.value = walletController.walletsList[1];
      }
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

  void handleFromFieldErrror() {
    var amount = fromAmountTextController.text;
    var minSwapAmount = double.parse(fromSelectedWallet.value.minSwapAmount);
    var maxSwapAmount = double.parse(fromSelectedWallet.value.maxSwapAmount);
    var currency = fromSelectedWallet.value.currency.toUpperCase();
    if (amount != '') {
      double receivedAmount = double.parse(amount);
      print(receivedAmount);
      if (receivedAmount < minSwapAmount) {
        fromFieldError = true;
        fromFieldErrorText.value = 'The amount has to be higher than ' +
            minSwapAmount.toString() +
            ' ' +
            currency;
      } else if (receivedAmount > maxSwapAmount) {
        fromFieldError = true;
        fromFieldErrorText.value = 'The amount has to be lower than ' +
            maxSwapAmount.toString() +
            ' ' +
            currency;
      } else if (receivedAmount >
          double.parse(fromSelectedWallet.value.balance)) {
        fromFieldError = true;
        fromFieldErrorText.value =
            'Your balance is not enough. Please fund your wallet.';
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
      print(exchangeRateRes);
      var rate = exchangeRateRes ~/ double.parse(fromAmountTextController.text);
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
      var exchangeRequestObj = {
        'base_currency': toSelectedWallet.value.currency,
        'qoute_currency': fromSelectedWallet.value.currency,
        'qoute_amount': fromAmountTextController.text,
        'otp': otpCodeTextController.text
      };

      var exchangeRateResponse =
          await _swapRepository.exchangeRequest(exchangeRequestObj);
      print(exchangeRateResponse);
      resetSwapForm();
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'account.exchanges.exchange.success');
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
    fromAmountTextController?.dispose();
    toAmountTextController?.dispose();
    otpCodeTextController?.dispose();
    super.onClose();
  }
}
