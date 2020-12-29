import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/views/wallet/deposit/crypto.dart';
import 'package:crypto_template/views/wallet/deposit/fiat.dart';
import 'package:crypto_template/views/wallet/withdraw/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;

class WalletSearch extends StatefulWidget {
  final String searchFrom;
  WalletSearch({this.searchFrom});
  _WalletSearchState createState() =>
      _WalletSearchState(searchFrom: searchFrom);
}

class _WalletSearchState extends State<WalletSearch> {
  final String searchFrom;
  _WalletSearchState({this.searchFrom});
  WalletController walletController = Get.find();
  TextEditingController _textController = TextEditingController();
  List<WalletClass.Wallet> newWalletList;

  @override
  void initState() {
    newWalletList = List.from(walletController.walletsList);
    super.initState();
  }

  void onItemChanged(String value) {
    setState(() {
      newWalletList = walletController.walletsList
          .where((wallet) =>
              wallet.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newWalletList.map((wallet) {
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
                          Get.off(DepositFiat(wallet: wallet));
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
                      // trailing: Icon(Icons.more_vert),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
