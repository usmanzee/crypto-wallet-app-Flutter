import 'package:b4u_wallet/component/no_data.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/controllers/wallet_search_controller.dart';
import 'package:b4u_wallet/views/wallet/deposit/crypto.dart';
import 'package:b4u_wallet/views/wallet/deposit/fiat.dart';
import 'package:b4u_wallet/views/wallet/withdraw/crypto.dart';
import 'package:b4u_wallet/views/wallet/withdraw/fiat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/models/wallet.dart' as WalletClass;

class WalletSearch extends GetView<WalletController> {
  final searchFrom = Get.arguments['searchFrom'];
  final TextEditingController _textController = TextEditingController();
  final WalletSearchController walletSearchController =
      Get.put(WalletSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          centerTitle: true,
          title: Text(
            'Search Wallet',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
          elevation: 0.8,
        ),
        body: Obx(() {
          if (controller.isLoading.value)
            return Container(
                width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          else
            return Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    border: Border.all(
                      color: Theme.of(context).canvasColor,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                      new Expanded(
                        child: TextField(
                          controller: _textController,
                          onChanged: controller.handleSearchInputChangeEvent,
                          cursorColor: Theme.of(context).textSelectionColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search...",
                            hintStyle: TextStyle(
                                color: Theme.of(context).textSelectionColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: controller.searchWalletsList.isEmpty
                      ? NoData()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
                            return walletList(ctx,
                                controller.searchWalletsList[i], searchFrom);
                          },
                          itemCount: controller.searchWalletsList.length,
                        ),
                )
              ],
            );
        }));
  }
}

Widget walletList(BuildContext ctx, WalletClass.Wallet wallet, searchFrom) {
  return Card(
    child: InkWell(
      onTap: () {
        if (wallet.type == 'coin') {
          if (searchFrom == 'deposit') {
            Get.off(DepositCrypto(wallet: wallet));
          } else {
            Get.off(WithdrawCrypto(wallet: wallet));
          }
        } else {
          if (searchFrom == 'deposit') {
            Get.off(DepositFiat(wallet: wallet));
          } else {
            Get.off(WithdrawFiat(wallet: wallet));
          }
        }
      },
      child: ListTile(
        leading: wallet.iconUrl != null
            ? Image.network(
                wallet.iconUrl,
                fit: BoxFit.contain,
                width: 35.0,
              )
            : Image.asset(
                'assets/image/market/BCH.png',
                fit: BoxFit.contain,
                width: 35.0,
              ),
        title: Text(wallet.currency.toUpperCase()),
        subtitle: Text(wallet.name),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    ),
  );
}
