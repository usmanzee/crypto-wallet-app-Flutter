import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/fiat_withdraw_controller.dart';
import 'package:crypto_template/repository/beneficiary_repository.dart';
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

  FiatWithdrawController fiatWithdrawController = Get.find();

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
    BeneficiaryRepository _beneficiaryRepository = new BeneficiaryRepository();
    try {
      Map<String, dynamic> requestObject = {
        "currency": wallet.currency,
        'name': descriptionTextController.text,
      };
      Map<String, dynamic> requestData = {
        "full_name": fullNameTextController.text,
        "account_number": accountNumberTextController.text,
        "bank_name": bankNameTextController.text
      };

      if (bankSwiftCodeTextController.text != null &&
          bankSwiftCodeTextController.text != '') {
        requestData["bank_swift_code"] = bankSwiftCodeTextController.text;
      }
      if (intermediaryBankNameTextController.text != null &&
          intermediaryBankNameTextController.text != '') {
        requestData['intermediary_bank_name'] =
            intermediaryBankNameTextController.text;
      }
      if (intermediaryBankSwiftCodeTextController.text != null &&
          intermediaryBankSwiftCodeTextController.text != '') {
        requestData['intermediary_bank_swift_code'] =
            intermediaryBankSwiftCodeTextController.text;
      }

      requestObject['data'] = requestData;

      var response = await _beneficiaryRepository.addBeneficiary(requestObject);
      fiatWithdrawController.beneficiariesList.add(response);
      fiatWithdrawController.beneficiariesList.refresh();
      Get.back();
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.beneficiaries.created'.tr);
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
