import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:get/get.dart';

class FiatDepositController extends GetxController {
  final String currency;
  FiatDepositController({this.currency});

  var isLoading = true.obs;
  var isBankDetailLoading = true.obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  @override
  void onInit() {
    fetchDepositBankDetails(currency);

    super.onInit();
  }

  fetchDepositBankDetails(currency) async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isBankDetailLoading(true);

      isBankDetailLoading(false);
    } catch (error) {
      print(error);
      isBankDetailLoading(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
