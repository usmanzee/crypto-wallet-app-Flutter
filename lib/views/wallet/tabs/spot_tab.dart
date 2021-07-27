import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/views/wallet/wallet_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotTab extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    /* var estimatedValueUSD = EstimatedValue.estimateValue(
      'USD',
      walletController.currenciesList,
      walletController.walletsList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    var estimatedValueSecondary = EstimatedValue.estimateUnitValue(
      'BTC',
      'USD',
      estimatedValueUSD,
      walletController.currenciesList,
      marketController.marketList,
      marketController.marketTickerList,
    );*/
    return Scaffold(
      body: Obx(() {
        return walletTabWidget(
          estimatedValueSecondary: walletController.estimatedValueSpot.value,
          estimatedValue:
              walletController.estimatedValueUsdSpot.value.toStringAsFixed(4),
          walletsList: walletController.walletsList,
          historyFunc: () {
            Get.toNamed('/spot_history_page');
          },
        );
      }),
    );
  }
}
