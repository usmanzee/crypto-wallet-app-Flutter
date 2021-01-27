import 'package:crypto_template/controllers/market_detail_controller.dart';
import 'package:crypto_template/controllers/swap_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class SwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => SwapController());
  }
}
