import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class WalletSearchController extends GetxController {
  var isLoading = true.obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  WalletController walletController = Get.find<WalletController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    walletController.searchWalletsList.assignAll(walletController.walletsList);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
