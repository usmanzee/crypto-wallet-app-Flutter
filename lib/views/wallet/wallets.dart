import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/views/wallet/estimated_widget.dart';
import 'package:crypto_template/views/wallet/wallet_detail.dart';
import 'package:crypto_template/views/wallet/wallet_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';

class Wallets extends StatelessWidget {
  final walletController = Get.put(WalletController());
  final MarketController marketController = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wallets',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1.0,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Obx(() {
                        if (walletController.isLoading.value) {
                          return ExtimatedPriceLoadingAnimation(
                            context: context,
                          );
                        } else {
                          return EstimatedWidget();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 8.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Currency",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (walletController.isLoading.value)
                return WalletLoadingAnimation(context: context);
              else
                return Container(
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return walletList(walletController.walletsList[i], ctx);
                    },
                    itemCount: walletController.walletsList.length,
                  ),
                );
            }),
          )
        ],
      ),
    );
  }
}

Widget walletList(WalletClass.Wallet wallet, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Get.to(WalletDetail(wallet: wallet));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                      child: wallet.iconUrl != null
                          ? Image.network(
                              wallet.iconUrl,
                              height: 25.0,
                              fit: BoxFit.contain,
                              width: 22.0,
                            )
                          : Image.asset(
                              'assets/image/market/BCH.png',
                              height: 22.0,
                              fit: BoxFit.contain,
                              width: 22.0,
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          wallet.currency.toUpperCase(),
                          style:
                              TextStyle(fontFamily: "Popins", fontSize: 16.5),
                        ),
                        Text(
                          wallet.name,
                          style: TextStyle(
                              fontFamily: "Popins",
                              fontSize: 11.5,
                              color: Theme.of(ctx).hintColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        (double.parse(wallet.balance) +
                                double.parse(wallet.locked))
                            .toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 19.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
          child: Container(
            width: double.infinity,
            height: 0.5,
            decoration:
                BoxDecoration(color: Theme.of(ctx).hintColor.withOpacity(0.1)),
          ),
        )
      ],
    ),
  );
}
