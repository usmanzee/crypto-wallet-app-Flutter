import 'package:b4u_wallet/models/transfer_response.dart';
import 'package:b4u_wallet/models/wallet.dart';
import 'package:b4u_wallet/repository/transfer_repository.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HomeController.dart';
import 'error_controller.dart';

class TransferController extends GetxController {
  var isLoading = false.obs;
  RxBool swap = false.obs;
  TextEditingController textController;
  ErrorController errorController = ErrorController();
  RxList<TransferResponse> currencyList = <TransferResponse>[].obs;
  RxList<Wallet> currentWalletList = <Wallet>[].obs;
  IconData walletIcon = Icons.people;
  RxString walletName = 'p2p'.obs;
  FocusNode focusNode;
  RxString currencyName = ''.obs;
  RxString currencyTotal = ''.obs;
  RxString currencyImage = MyImgs.testPhoto.obs;
  RxString transferButtonText = 'Transfer'.obs;

  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    // fetchCurrencyList();
    textController = TextEditingController();
    focusNode = FocusNode();
    super.onInit();
  }

  Future<bool> transferAsset({
    String amount,
    String currencyCode,
    String sourceWallet,
    String targetWallet,
  }) async {
    isLoading(true);
    TransferRepository _transferRepository = TransferRepository();
    Map<String, String> map = {
      'amount': amount,
      'currency': currencyCode,
      'source_wallet': sourceWallet,
      'target_wallet': targetWallet,
    };
    try {
      final TransferResponse response =
          await _transferRepository.transferAsset(map);
      if (response.id != null) {
        isLoading(false);
        return true;
      }
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
      return false;
    }
  }

  Future<void> fetchCurrencyList({String category}) async {
    isLoading(true);
    TransferRepository _transferRepository = TransferRepository();
    String value = category == null ? 'p2p' : category;
    try {
      final List<TransferResponse> response =
          await _transferRepository.fetchCurrencyList(category: value);
      if (response.length > 0) {
        isLoading(false);
        // add the list here.
        currencyList.addAll(response);
        print(currencyList[0].id);
      }
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
