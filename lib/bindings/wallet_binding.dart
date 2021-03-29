import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => WalletController());
  }
}
