import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/utils/Helpers/estimate_value.dart';

class EstimatedWidget extends StatelessWidget {
  final walletController = Get.put(WalletController());
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    var estimatedValue = EstimatedValue.estimateValue(
        'USD',
        walletController.currenciesList,
        walletController.walletsList,
        marketController.marketList,
        marketController.marketTickerList);
    var estimatedValueSecondary = EstimatedValue.estimateUnitValue(
        'BTC',
        'USD',
        estimatedValue,
        walletController.currenciesList,
        marketController.marketList,
        marketController.marketTickerList);
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text('wallets.screen.equity_value'.tr + '(BTC)',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left),
          SizedBox(
            height: 4,
          ),
          Text(estimatedValueSecondary,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.left),
          Text('≈ \$' + estimatedValue.toString(),
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.left),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                height: 32.0,
                minWidth: 120.0,
                textColor: Theme.of(context).accentColor,
                child: Text(
                  "wallets.screen.button.deposit".tr,
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  Get.toNamed('/wallets-search',
                      arguments: {'searchFrom': 'deposit'});
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                splashColor: Theme.of(context).accentColor.withOpacity(0.5),
              ),
              SizedBox(
                width: 8.0,
              ),
              FlatButton(
                height: 32.0,
                minWidth: 120.0,
                textColor: Theme.of(context).accentColor,
                child: Text(
                  "wallets.screen.button.deposit".tr,
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  Get.toNamed('/wallets-search',
                      arguments: {'searchFrom': 'withdraw'});
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).accentColor,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                splashColor: Theme.of(context).accentColor.withOpacity(0.5),
              )
            ],
          )
        ],
      ),
    );
  }
}
