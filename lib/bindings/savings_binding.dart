import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:get/get.dart';

class SavingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavingsController());
    Get.lazyPut(() => WalletController());
  }
}