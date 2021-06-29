import 'package:get/get.dart';
import 'package:b4u_wallet/controllers/transfer_controller.dart';

class TransferBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TransferController());
  }
}