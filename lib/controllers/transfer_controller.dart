import 'package:b4u_wallet/models/transfer_response.dart';
import 'package:b4u_wallet/repository/transfer_repository.dart';
import 'package:get/get.dart';
import 'error_controller.dart';

class TransferController extends GetxController {
  var isLoading = false.obs;
  ErrorController errorController = ErrorController();

  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }
  Future<bool> transferAsset({String amount,String currencyCode,String sourceWallet,String targetWallet }) async {
    isLoading(true);
    TransferRepository _transferRepository = new TransferRepository();
    Map<String,String> map = {
      'amount' : amount,
      'currency' : currencyCode,
      'source_wallet' : sourceWallet,
      'target_wallet' : targetWallet,
    };
    try {
      final TransferResponse response =
      await _transferRepository.transferAsset(map);
      if(response.id != null){
        isLoading(false);
        return true;
      }
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
      return false;

    }
  }
  @override
  void onClose() {
    super.onClose();
  }

}