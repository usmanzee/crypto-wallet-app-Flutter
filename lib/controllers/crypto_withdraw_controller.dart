import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/repository/wallet_repository.dart';
import 'package:b4u_wallet/models/wallet.dart' as WalletClass;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class CryptoWithdrawController extends GetxController {
  // final WalletClass.Wallet wallet;
  // CryptoWithdrawController({this.wallet});
  WalletClass.Wallet wallet = Get.arguments['wallet'];

  TextEditingController withdrawAddressController;
  TextEditingController withdrawTagController;
  TextEditingController withdrawAmountController;
  TextEditingController withdrawOtpController;

  var address = ''.obs;
  var amount = '0.0'.obs;
  var totalWithdrawlAmount = 0.0.obs;
  var withdrawingCrypto = false.obs;
  var scannedAddress = null.obs;

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
      await _walletRepository.withdrawCrypto(requestData);
      resetWithdrawForm();
      withdrawingCrypto(false);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.withdraw.action'.tr);
      snackbarController.showSnackbar();
    } catch (error) {
      withdrawingCrypto(false);
      Get.back();
      errorController.handleError(error);
    }
  }

  Future scanQRCode() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      withdrawAddressController.text = barcode;
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
