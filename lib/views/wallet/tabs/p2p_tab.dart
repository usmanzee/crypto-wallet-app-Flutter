import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/utils/Helpers/estimate_value.dart';
import 'package:b4u_wallet/views/wallet/wallet_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2PTab extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    var estimatedValue = EstimatedValue.estimateValue(
      'USD',
      walletController.currenciesList,
      walletController.p2pWalletsList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    var estimatedValueSecondary = EstimatedValue.estimateUnitValue(
      'BTC',
      'USD',
      estimatedValue,
      walletController.currenciesList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    return Scaffold(
      body: Obx(
        () {
          return WalletTabWidget(
              walletsList: walletController.p2pWalletsList,
              estimatedValueSecondary: estimatedValueSecondary,
              estimatedValue: estimatedValue.toString());
        },
      ),
    );
  }
}
