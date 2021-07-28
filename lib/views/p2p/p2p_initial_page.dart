import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_sell_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_express_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pInitialPage extends StatelessWidget {
  final P2pController p2pController = Get.find();

 /* @override
  Widget build(BuildContext context) {
    print(p2pController.buySellOrExpress.value);
    return WillPopScope(
      child: Obx(
        () => p2pController.buySellOrExpress.value
            ? P2pBuySellPage()
            : P2pExpressPage(),
      ),
      onWillPop: () async{
        disposeController(context);
        return true;
      },
    );
  }

  void disposeController(BuildContext context) {
    p2pController.dispose();
  }*/
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => p2pController.buySellOrExpress.value
          ? P2pBuySellPage()
          : P2pExpressPage(),
    );
  }
}
