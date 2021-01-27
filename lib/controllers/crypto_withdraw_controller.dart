import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoWithdrawController extends GetxController {
  final WalletClass.Wallet wallet;
  CryptoWithdrawController({this.wallet});

  TextEditingController withdrawAddressController;
  TextEditingController withdrawTagController;
  TextEditingController withdrawAmountController;
  TextEditingController withdrawOtpController;

  var address = ''.obs;
  var amount = '0.0'.obs;
  var totalWithdrawlAmount = 0.0.obs;
  var withdrawingCrypto = false.obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find();

  @override
  void onInit() {
    withdrawAddressController = TextEditingController();
    withdrawTagController = TextEditingController();
    withdrawAmountController = TextEditingController();
    withdrawOtpController = TextEditingController();
    homeController.fetchUser();
    homeController.fetchMemberLevels();
    super.onInit();
  }

  void resetWithdrawForm() {
    withdrawAddressController.clear();
    withdrawTagController.clear();
    withdrawAmountController.clear();
    withdrawOtpController.clear();
  }

  void withdraw(_formKey) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    WalletRepository _walletRepository = new WalletRepository();
    try {
      withdrawingCrypto(true);
      var requestData = {
        'rid': withdrawAddressController.text,
        'amount': withdrawAmountController.text,
        'currency': wallet.currency,
        'otp': withdrawOtpController.text
      };
      if (wallet.currency == 'xrp' &&
          (withdrawTagController.text != null ||
              withdrawTagController.text != '')) {
        requestData['rid'] =
            requestData['rid'] + '?dt=' + withdrawTagController.text;
      }
      print(requestData);
      var response = await _walletRepository.withdrawCrypto(requestData);
      print(response);
      resetWithdrawForm();
      withdrawingCrypto(false);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.withdraw.action');
      snackbarController.showSnackbar();
    } catch (error) {
      withdrawingCrypto(false);
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    withdrawAddressController?.dispose();
    withdrawTagController?.dispose();
    withdrawAmountController?.dispose();
    withdrawOtpController?.dispose();
    super.onClose();
  }
}
