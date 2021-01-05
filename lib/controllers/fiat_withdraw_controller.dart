import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/Beneficiary.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FiatWithdrawController extends GetxController {
  final WalletClass.Wallet wallet;
  FiatWithdrawController({this.wallet});

  TextEditingController withdrawBeneficiaryController;
  TextEditingController withdrawAmountController;
  TextEditingController withdrawOtpController;

  var beneficiariesList = List<Beneficiary>().obs;
  var amount = '0.0'.obs;
  var totalWithdrawlAmount = 0.0.obs;
  var withdrawingFiat = false.obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController;

  @override
  void onInit() {
    withdrawBeneficiaryController = TextEditingController();
    withdrawAmountController = TextEditingController();
    withdrawOtpController = TextEditingController();
    homeController = Get.find();
    fetchBeneficiaries();
    super.onInit();
  }

  void resetWithdrawForm() {
    withdrawBeneficiaryController.clear();
    withdrawAmountController.clear();
    withdrawOtpController.clear();
  }

  void fetchBeneficiaries() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      var beneficiaries = await _walletRepository.fetchBeneficiaries();
      beneficiariesList.assignAll(beneficiaries);
    } catch (error) {
      errorController.handleError(error);
    }
  }

  void withdraw(_formKey) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    WalletRepository _walletRepository = new WalletRepository();
    try {
      withdrawingFiat(true);
      var requestData = {
        'rid': withdrawBeneficiaryController.text,
        'amount': withdrawAmountController.text,
        'currency': wallet.currency,
        'otp': withdrawOtpController.text
      };

      print(requestData);
      var response = await _walletRepository.withdrawCrypto(requestData);
      print(response);
      resetWithdrawForm();
      withdrawingFiat(false);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.withdraw.action');
      snackbarController.showSnackbar();
    } catch (error) {
      withdrawingFiat(false);
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    withdrawBeneficiaryController?.dispose();
    withdrawAmountController?.dispose();
    withdrawOtpController?.dispose();
    super.onClose();
  }
}
