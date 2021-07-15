import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EstimatedWidget extends StatelessWidget {
  final walletController = Get.put(WalletController());

  final MarketController marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    /*double estimatedValueUSD = EstimatedValue.estimateValue(
        'USD',
        walletController.currenciesList,
        walletController.walletsList,
        marketController.marketList,
        marketController.marketTickerList);
    String estimatedValueSecondary = EstimatedValue.estimateUnitValue(
        'BTC',
        'USD',
        estimatedValueUSD,
        walletController.currenciesList,
        marketController.marketList,
        marketController.marketTickerList);*/
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('wallets.screen.equity_value'.tr + '(BTC)',
                    style: Get.theme.textTheme.bodyText1.copyWith(color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),),
                    textAlign: TextAlign.left,),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: () {
                    walletController.visibility.value =
                        !walletController.visibility.value;
                    print('from tabs');
                  },
                  child: Icon(
                    walletController.visibility.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                    color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  walletController.visibility.value ? walletController.estimatedValueAll.value : '*****',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                walletController.visibility.value ? '≈ \$' + walletController.estimatedValueUSDAll.value.toStringAsFixed(4) : '*****',
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: GestureDetector(
                    onTap: () {
                      _showDialog(
                          context: context,
                          info:
                              'Your assets balances may not be up to date due to a system delay. To obtain a more accurate balance, please proceed to the specific asset page to check.');
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Get.theme.accentColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                button(
                    main: true,
                    text: "wallets.screen.button.deposit".tr,
                    callBack: () {
                      Get.toNamed('/wallets-search',
                          arguments: {'searchFrom': 'deposit'});
                    }),
                SizedBox(
                  width: 8.0,
                ),
                button(
                    text: "wallets.screen.button.withdraw".tr,
                    callBack: () {
                      Get.toNamed('/wallets-search',
                          arguments: {'searchFrom': 'withdraw'});
                    }),
                SizedBox(
                  width: 8.0,
                ),
                button(
                    callBack: () {
                      Get.toNamed('/transfer_page');
                    },
                    text: 'Transfer'),
              ],
            ),
          ],
        ),
      );
    });
  }

  void _showDialog({BuildContext context, String info}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          // title: Center(child: Text(heading)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(info),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Get.theme.accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget button({String text, Function callBack, bool main = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: callBack,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: main
                ? Get.theme.accentColor.withOpacity(0.8)
                : Get.theme.canvasColor,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Popins",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: main ? Get.theme.scaffoldBackgroundColor : Get.theme.textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
