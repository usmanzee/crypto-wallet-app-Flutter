import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_sell_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_express_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pInitialPage extends StatelessWidget {
  final p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => p2pController.buySellOrExpress.value ? P2pBuySellPage(): P2pExpressPage());
  }
}
