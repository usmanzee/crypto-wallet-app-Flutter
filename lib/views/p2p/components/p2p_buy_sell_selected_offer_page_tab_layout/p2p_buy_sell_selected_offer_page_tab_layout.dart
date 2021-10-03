import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/components/p2p_buy_sell_selected_offer_page_tab_layout/tabs/by_crypto.dart';
import 'package:b4u_wallet/views/p2p/components/p2p_buy_sell_selected_offer_page_tab_layout/tabs/by_fiat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellSelectedOfferPageTabLayout extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            print(scrollNotification.metrics.extentBefore);
            if (scrollNotification.metrics.extentBefore == 0.0) {
              _p2pController.fiatOrCrypto.value = true;
            }
            if (scrollNotification.metrics.extentBefore > 300) {
              _p2pController.fiatOrCrypto.value = false;
            }
          }
          print(_p2pController.fiatOrCrypto.value);
          return true;
        },
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelColor: Get.theme.primaryColor,
                unselectedLabelColor:
                    Get.theme.textSelectionTheme.selectionColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    child: Text(
                      'By Fiat',
                      style: TextStyle(fontFamily: "Popins", fontSize: 14),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'By Crypto',
                      style: TextStyle(fontFamily: "Popins", fontSize: 14),
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 0.3,
                color: Get.theme.hintColor,
              ),
              SizedBox(height: 16,),
              Container(
                height: Get.height * 0.31,
                child: TabBarView(
                  children: [
                    ByFiat(),
                    ByCrypto(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
