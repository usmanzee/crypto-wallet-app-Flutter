import 'package:crypto_template/controllers/market_detail_controller.dart';
import 'package:crypto_template/controllers/swap_history_controller.dart';
import 'package:get/get.dart';

class SwapHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwapHistoryController());
  }
}
