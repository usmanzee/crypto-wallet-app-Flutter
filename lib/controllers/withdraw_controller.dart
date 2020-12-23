import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawController extends GetxController {
  // WithdrawController();
  TextEditingController withdrawAddressController;
  TextEditingController withdrawAmountController;
  TextEditingController withdrawOtpController;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController;

  @override
  void onInit() {
    withdrawAddressController = TextEditingController();
    withdrawAmountController = TextEditingController();
    withdrawOtpController = TextEditingController();
    homeController = Get.find();
    super.onInit();
  }

  @override
  void onClose() {
    withdrawAddressController?.dispose();
    withdrawAmountController?.dispose();
    withdrawOtpController?.dispose();
    super.onClose();
  }
}
