import 'package:b4u_wallet/controllers/transfer_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletsList extends StatelessWidget {
  final Function callback;
  final transferController = Get.find<TransferController>();
  final walletController = Get.find<WalletController>();
  WalletsList(this.callback);

  final List<WalletName> walletNames = [
    WalletName(
      name: 'P2P',
      icon: Icons.people_outline,
    ),
    WalletName(
      name: 'Saving',
      icon: Icons.account_balance_wallet_outlined,
    )
  ];

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
            child: ListView.builder(
              itemCount: walletNames.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:(){
                    transferController.currentWalletList.assignAll(index == 0 ? walletController.p2pWalletsList : walletController.savingWalletsList);
                    callback(name: walletNames[index].name,icon:walletNames[index].icon,);
                    Get.back();
                  },
                  child: _container(
                      icon: walletNames[index].icon,
                      name: walletNames[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _container({
    @required IconData icon,
    @required String name,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                  child:
                      /*wallet.iconUrl != null
                    ? Image.network(
                  wallet.iconUrl,
                  height: 25.0,
                  fit: BoxFit.contain,
                  width: 22.0,
                )
                    :*/
                      //todo: add the handling for the url if that is empty
                      Icon(
                    icon,
                    color: Get.theme.accentColor,
                  )),
              Text(
                '$name Wallet',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // todo: add the callback here for the selected list from the start.
          /*Icon(
            Icons.check,
          ),*/
        ],
      ),
    );
  }
}

class WalletName {
  IconData icon;
  String name;

  WalletName({this.icon, this.name});
}
