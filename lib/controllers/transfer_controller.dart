import 'package:b4u_wallet/models/transfer_response.dart';
import 'package:b4u_wallet/repository/transfer_repository.dart';
import 'package:get/get.dart';
import 'error_controller.dart';

class TransferController extends GetxController {
  var isLoading = false.obs;
  ErrorController errorController = ErrorController();
  RxList<TransferResponse> currencyList = [].obs;

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

  Future<void> fetchCurrencyList({String category})async{
    isLoading(true);
    TransferRepository _transferRepository = TransferRepository();
    String value = category == null ? 'p2p' : category;
    try {
      final List<TransferResponse> response =
          await _transferRepository.fetchCurrencyList(category:value);
      if(response.length > 0){
        isLoading(false);
        // add the list here.
        currencyList.value.addAll(response);
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