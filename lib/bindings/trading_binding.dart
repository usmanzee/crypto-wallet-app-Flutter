import 'package:b4u_wallet/controllers/trading_controller.dart';
import 'package:get/get.dart';

class TradingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TradingController());
  }
}
