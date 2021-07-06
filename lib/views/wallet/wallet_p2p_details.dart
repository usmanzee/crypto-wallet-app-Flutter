import 'package:b4u_wallet/models/wallet.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletP2PDetails extends StatelessWidget {
  final Wallet wallet;

  WalletP2PDetails(this.wallet);

  @override
  Widget build(BuildContext context) {
    final total = (double.parse(wallet.balance) + double.parse(wallet.locked)).toStringAsFixed(6);
    /*print(wallet.balance);
    print(wallet.name);
    print(wallet.currency);
    print(wallet.accountType);
    print(wallet.type);
    print(wallet.iconUrl);
    print(wallet.address);
    print(wallet.depositEnabled);
    print(wallet.explorerAddress);
    print(wallet.explorerTransaction);
    print(wallet.fee);
    print(wallet.fixed);
    print(wallet.locked);
    print(wallet.precision);*/
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        elevation: 0,
        title: Text('balance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      //todo : add the image.network here when the icons are coming from the server.
                      MyImgs.testPhoto,
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wallet.currency.toUpperCase(),
                          style: TextStyle(
                            color: Get.theme.textSelectionTheme.selectionColor,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          wallet.name,
                          style: TextStyle(
                            color: Get.theme.textSelectionTheme.selectionColor,
                            fontFamily: "Popins",
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                rowText(
                  name: 'Total',
                  value: total,
                ),
                rowText(
                  name: 'Available',
                  value: (double.parse(wallet.balance) -
                      double.parse(wallet.locked)).toString(),
                ),
                rowText(
                  name: 'In Order',
                  value: wallet.locked,
                ),
                rowText(name: '', value: ''),
                /*rowText(
                  name: 'Estimated Value (BTC)',
                  value: '0.000000000',
                ),
                rowText(
                  name: 'Estimated Value (\$)',
                  value: '\$0.000000000',
                ),*/
              ],
            ),
            Row(
              children: [
                button(
                  name: 'Buy',
                  color: true,
                  callBack: () {},
                ),
                SizedBox(
                  width: 8,
                ),
                button(
                  name: 'Sell',
                  callBack: () {},
                ),
                SizedBox(
                  width: 8,
                ),
                button(
                  name: 'Transfer',
                  callBack: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget rowText({
  String name,
  String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),
            fontFamily: "Popins",
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Get.theme.textSelectionTheme.selectionColor,
            fontFamily: "Popins",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

Widget button({
  String name,
  Function callBack,
  bool color = false,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color ? Get.theme.colorScheme.secondary : Get.theme.canvasColor,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: color ? Get.theme.scaffoldBackgroundColor : Get.theme
                .textSelectionTheme.selectionColor,
            fontFamily: "Popins",
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
