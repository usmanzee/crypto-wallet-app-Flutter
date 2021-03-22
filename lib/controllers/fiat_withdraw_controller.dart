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

  var selectedWithdrawBeneficiary = Beneficiary().obs;
  TextEditingController withdrawAmountController;
  TextEditingController withdrawOtpController;

  var isBeneficiariesLoading = true.obs;
  var beneficiariesList = List<Beneficiary>().obs;
  var amount = '0.0'.obs;
  var totalWithdrawlAmount = 0.0.obs;
  var withdrawingFiat = false.obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find();

  @override
  void onInit() {
    // withdrawBeneficiaryController = TextEditingController();
    withdrawAmountController = TextEditingController();
    withdrawOtpController = TextEditingController();
    homeController.fetchUser();
    homeController.fetchMemberLevels();
    fetchBeneficiaries();
    super.onInit();
  }

  void resetWithdrawForm() {
    // withdrawBeneficiary.value = '';
    withdrawAmountController.clear();
    withdrawOtpController.clear();
  }

  void fetchBeneficiaries() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isBeneficiariesLoading(true);
      var beneficiaries = await _walletRepository.fetchBeneficiaries();
      await filterBeneficiaries(beneficiaries);
      isBeneficiariesLoading(false);
    } catch (error) {
      isBeneficiariesLoading(false);
      errorController.handleError(error);
    }
  }

  Future<void> filterBeneficiaries(List<Beneficiary> beneficiaries) async {
    var filteredBeneficiaries = beneficiaries
        .where((Beneficiary beneficiary) =>
            beneficiary.currency.toLowerCase() == wallet.currency.toLowerCase())
        .toList();
    print(filteredBeneficiaries);
    if (filteredBeneficiaries.length > 0) {
      selectedWithdrawBeneficiary.value = filteredBeneficiaries[0];
    }
    beneficiariesList.assignAll(filteredBeneficiaries);
  }

  void withdraw(_formKey) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    WalletRepository _walletRepository = new WalletRepository();
    try {
      withdrawingFiat(true);
      var requestData = {
        'beneficiary_id': selectedWithdrawBeneficiary.value.id.toString(),
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
          title: 'Success', message: 'success.withdraw.action'.tr);
      snackbarController.showSnackbar();
    } catch (error) {
      withdrawingFiat(false);
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    // withdrawBeneficiaryController?.dispose();
    withdrawAmountController?.dispose();
    withdrawOtpController?.dispose();
    super.onClose();
  }
}
