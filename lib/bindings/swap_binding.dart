import 'package:b4u_wallet/controllers/swap_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class SwapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => SwapController());
  }
}
