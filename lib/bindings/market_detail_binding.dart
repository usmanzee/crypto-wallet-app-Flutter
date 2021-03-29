import 'package:b4u_wallet/controllers/market_detail_controller.dart';
import 'package:get/get.dart';

class MarketDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarketDetailController());
  }
}
