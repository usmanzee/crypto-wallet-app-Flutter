import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<MarketController>(MarketController());
  }
}
