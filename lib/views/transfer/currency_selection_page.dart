import 'package:b4u_wallet/controllers/transfer_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/models/wallet.dart';
import 'package:b4u_wallet/views/wallet/wallet_loading_animation.dart';
import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/models/wallet.dart' as WalletClass;

class CurrencySelection extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final List<Wallet> walletData;
  final _transferController = Get.find<TransferController>();
  CurrencySelection({this.walletData,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Select a wallet',
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.textSelectionTheme.selectionColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (walletController.isLoading.value)
                  return WalletLoadingAnimation(context: context);
                else
                  return Container(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                       /* print('The id of the currencies are ${walletData[i].name}');*/
                        return walletList(
                          walletData[i],
                          // walletController.p2pWalletsList[i],
                        );
                      },
                      itemCount: walletController.p2pWalletsList.length,
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget walletList(
    WalletClass.Wallet wallet,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              //todo: add the callback here and update the value in the previous widget
              _transferController.currencyName.value = wallet.currency;
              // _transferController.currencyImage.value = wallet.iconUrl;
              _transferController.currencyTotal.value = (double.parse(wallet.balance) +
                  double.parse(wallet.locked))
                  .toStringAsFixed(wallet.type == 'fiat' ? 2 : 6);
              _transferController.currencyImage.value = wallet.iconUrl;
              print(wallet.iconUrl);
              Get.back();
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
                        child:iconWidget(url: wallet.iconUrl,name: wallet.name)
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
                                color: Get.theme.hintColor),
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
                              .toStringAsFixed(wallet.type == 'fiat' ? 2 : 6),
                          style: TextStyle(
                              fontFamily: "Popins",
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600),
                        ),
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
                  BoxDecoration(color: Get.theme.hintColor.withOpacity(0.1)),
            ),
          ),
        ],
      ),
    );
  }
}
