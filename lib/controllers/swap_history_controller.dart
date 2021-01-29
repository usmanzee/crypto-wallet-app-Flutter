import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/swap_history_response.dart';
import 'package:crypto_template/repository/swap_repository.dart';
import 'package:get/get.dart';

class SwapHistoryController extends GetxController {
  var isLoading = false.obs;
  var swapHistoryList = List<SwapHistoryResponse>().obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchHistory() async {
    SwapRepository _swapRepository = new SwapRepository();
    try {
      isLoading(true);
      var historyResponse = await _swapRepository.fetchSwapHistory();

      swapHistoryList.assignAll(historyResponse);
      isLoading(false);
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
