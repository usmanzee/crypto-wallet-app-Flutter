import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:get/get.dart';

class DepositController extends GetxController {
  final String currency;
  DepositController({this.currency});

  var isLoading = true.obs;
  var isAddressLoading = true.obs;
  var depositAddress = ''.obs;
  var depositTag = ''.obs;
  SnackbarController snackbarController;

  @override
  void onInit() {
    fetchDepositAddress(currency);
    // if (currency == 'xrp') {
    //   Get.defaultDialog(title: 'This is title');
    // }
    super.onInit();
  }

  fetchDepositAddress(currency) async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isAddressLoading(true);
      var depositAddressResponse =
          await _walletRepository.fetchDepositAddress(currency);
      if (!depositAddressResponse.address.isNull) {
        var addressArr = depositAddressResponse.address.split('?dt=');
        depositAddress.value = addressArr[0];
        depositTag.value = addressArr.length == 2 ? addressArr[1] : '';
      }
      isAddressLoading(false);
    } catch (error) {
      print(error);
      isAddressLoading(false);
      var errorResponseObj = error.errorResponse();
      snackbarController = new SnackbarController(
          title: 'Error', message: errorResponseObj['message']);
      snackbarController.showSnackbar();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
