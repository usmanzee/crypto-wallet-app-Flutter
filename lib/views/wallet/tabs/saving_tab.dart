import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/utils/Helpers/estimate_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet_tab_widget.dart';

class SavingTab extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    /*var estimatedValueUSD = EstimatedValue.estimateValue(
      'USD',
      walletController.currenciesList,
      walletController.savingWalletsList,
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
      body: Obx(
        () {
          return walletTabWidget(
              walletsList: walletController.savingWalletsList,
              estimatedValueSecondary: walletController.estimatedValueSaving.value,
              estimatedValue: walletController.estimatedValueUsdSaving.value.toStringAsFixed(4));
        },
      ),
    );
  }
}
