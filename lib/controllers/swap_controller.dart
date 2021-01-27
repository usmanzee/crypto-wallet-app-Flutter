import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapController extends GetxController {
  TextEditingController fromAmountTextController;
  TextEditingController toAmountTexttroller;

  var isLoading = false.obs;
  var amount = '0.0'.obs;
  var totalWithdrawlAmount = 0.0.obs;
  var withdrawingCrypto = false.obs;
  var fromWalletsList = List<Wallet>().obs;
  var toWalletsList = List<Wallet>().obs;
  var fromSelectedWallet = Wallet().obs;
  var toSelectedWallet = Wallet().obs;
  var _selectedWalletIndex = 0.obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find();
  final WalletController walletController = Get.find();

  get selectedWalletIndex => this._selectedWalletIndex.value;
  set selectedWalletIndex(index) => this._selectedWalletIndex.value = index;

  @override
  void onInit() {
    isLoading(true);
    fromAmountTextController = TextEditingController();
    toAmountTexttroller = TextEditingController();
    if (!walletController.isLoading.value) {
      fromWalletsList = walletController.walletsList;
      toWalletsList = walletController.walletsList;
      fromSelectedWallet.value = walletController.walletsList[0];
      toSelectedWallet.value = walletController.walletsList[1];
    }
    ever(walletController.walletsList, setWalletValues);
    super.onInit();
  }

  setWalletValues(walletsList) {
    isLoading(false);
    fromWalletsList.assignAll(walletsList);
    toWalletsList.assignAll(walletsList);
    if (walletsList.length > 0) {
      fromSelectedWallet.value = walletsList[0];
      toSelectedWallet.value = walletsList[1];
    }
  }

  void resetWithdrawForm() {
    fromAmountTextController.clear();
    toAmountTexttroller.clear();
  }

  @override
  void onClose() {
    fromAmountTextController?.dispose();
    toAmountTexttroller?.dispose();
    super.onClose();
  }
}
