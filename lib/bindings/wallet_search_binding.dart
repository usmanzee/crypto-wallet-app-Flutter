import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class WalletSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
  }
}
