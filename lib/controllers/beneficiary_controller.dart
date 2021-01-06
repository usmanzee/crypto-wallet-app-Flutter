import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/Beneficiary.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryController extends GetxController {
  final WalletClass.Wallet wallet;
  BeneficiaryController({this.wallet});

  TextEditingController descriptionTextController;
  TextEditingController fullNameTextController;
  TextEditingController accountNumberTextController;
  TextEditingController bankNameTextController;
  TextEditingController bankSwiftCodeTextController;
  TextEditingController intermediaryBankNameTextController;
  TextEditingController intermediaryBankSwiftCodeTextController;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController;

  @override
  void onInit() {
    descriptionTextController = TextEditingController();
    fullNameTextController = TextEditingController();
    accountNumberTextController = TextEditingController();
    bankNameTextController = TextEditingController();
    bankSwiftCodeTextController = TextEditingController();
    intermediaryBankNameTextController = TextEditingController();
    intermediaryBankSwiftCodeTextController = TextEditingController();
    homeController = Get.find();
    super.onInit();
  }

  void addBeneficiary() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    WalletRepository _walletRepository = new WalletRepository();
    try {
      // var requestData = {
      //   'amount': withdrawAmountController.text,
      //   'currency': wallet.currency,
      //   'otp': withdrawOtpController.text
      // };

      // print(requestData);
      // var response = await _walletRepository.withdrawCrypto(requestData);
      // print(response);
      // Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.withdraw.action');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    descriptionTextController?.dispose();
    fullNameTextController?.dispose();
    accountNumberTextController?.dispose();
    bankNameTextController?.dispose();
    bankSwiftCodeTextController?.dispose();
    intermediaryBankNameTextController?.dispose();
    intermediaryBankSwiftCodeTextController?.dispose();
    super.onClose();
  }
}
