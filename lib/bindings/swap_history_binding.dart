import 'package:b4u_wallet/controllers/swap_history_controller.dart';
import 'package:get/get.dart';

class SwapHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwapHistoryController());
  }
}
