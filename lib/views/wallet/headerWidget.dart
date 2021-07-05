import 'dart:ui';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/views/p2p_buy_sell_page/p2p_buy_sell_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final walletController = Get.find<WalletController>();

Widget headerWidget({String firstValue, String secondValue,bool p2p = false}) {
  return Obx((){
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Equity Value (BTC) ',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.textSelectionTheme.selectionColor
                                .withOpacity(0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            walletController.visibility.value =
                            !walletController.visibility.value;
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
                    Icon(
                      Icons.insert_drive_file_outlined,
                      color: Get.theme.textSelectionTheme.selectionColor
                          .withOpacity(0.7),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
//daa the variables here...
                      Text(
                        walletController.visibility.value ? firstValue : '*****',
                        style: Get.theme.textTheme.headline5,
                      ),
                      Text(
                        ' ≈ ',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.textSelectionTheme.selectionColor
                              .withOpacity(0.7),
                        ),
                      ),
                      Text(
                        walletController.visibility.value ? '\$$secondValue' : '*****',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.textSelectionTheme.selectionColor
                              .withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
// can be added later on.
/* Row(
                children: [
                  Text(
                    'Yesterday\'s PNL ',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Get.theme.textSelectionTheme.selectionColor
                          .withOpacity(0.7),
                    ),
                  ),
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Get.theme.textSelectionTheme.selectionColor
                        .withOpacity(0.7),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    Text('--'),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(
                      text: p2p ? 'Buy' : 'Deposit',
                      main: true,
                      callBack: () {
                        // todo : add the p2p buy page
                         p2p ? Get.to(P2pBuySellPage()) : Get.toNamed('/wallets-search',
                            arguments: {'searchFrom': 'deposit'});
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    button(
                      text: p2p ? 'Sell' : 'Withdraw',
                      callBack: () {
                        // todo : add the p2p buy page
                        p2p ? 'Get.' :
                        Get.toNamed('/wallets-search',
                            arguments: {'searchFrom': 'withdraw'});
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    button(
                      text: 'Transfer',
                      callBack: () {
                        Get.toNamed('/transfer_page');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 3,
              width: double.infinity,
              color: Get.theme.canvasColor,
            ),
          ),
/*Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Convert small assets to BNB',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.accentColor.withOpacity(0.7),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Get.theme.textSelectionTheme.selectionColor
                    .withOpacity(0.7),
              ),
            ],
          ),
        ),*/
        ],
      ),
    );
  });
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
              color: main
                  ? Get.theme.scaffoldBackgroundColor
                  : Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
        ),
      ),
    ),
  );
}
