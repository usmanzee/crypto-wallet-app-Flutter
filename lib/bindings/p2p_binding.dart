import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:get/get.dart';

class P2pBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => P2pController());
  }
}