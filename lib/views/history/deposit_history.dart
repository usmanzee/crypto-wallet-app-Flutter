import 'package:b4u_wallet/component/history_detail.dart';
import 'package:b4u_wallet/component/no_data.dart';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/history_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/models/deposit_histroy_response.dart';
import 'package:b4u_wallet/views/webview_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:b4u_wallet/models/wallet.dart' as WalletClass;

class DepositHistory extends StatelessWidget {
  final HistoryController historyController = Get.find();
  final WalletController walletController = Get.find<WalletController>();
  final HomeController homeController = Get.find<HomeController>();
  void handleURLButtonPress(String currency, String txid) {
    String blockchainLink = getBlockchainLink(currency, txid);
    Get.to(WebViewContainer('Explorer', blockchainLink));
  }

  String getBlockchainLink(currency, txid) {
    var wallets = walletController.walletsList;
    WalletClass.Wallet currencyInfo =
        wallets.firstWhere((wallet) => wallet.currency == currency);
    if (currencyInfo != null) {
      if ((txid != '' && txid != null) &&
          (currencyInfo.explorerTransaction != '' &&
              currencyInfo.explorerTransaction != null)) {
        var bLink =
            currencyInfo.explorerTransaction.replaceFirst('#{txid}', txid);
        return bLink;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: historyController.refreshDepositHistory,
      child: Obx(() {
        if (historyController.isDepositHistoryLoading.value ||
            homeController.fetchingMemberLevel.value)
          return Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        else
          return historyController.depositHistory.isEmpty
              ? NoData()
              : Container(
                  child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 0.0),
                  itemBuilder: (ctx, i) {
                    return _depositHistoryList(
                      context,
                      historyController.depositHistory[i],
                    );
                  },
                  itemCount: historyController.depositHistory.length,
                ));
      }),
    );
  }

  Widget _depositHistoryList(
      BuildContext context, DepositHistoryResponse depositHistoryItem) {
    Color _color;
    IconData _icon;
    if (depositHistoryItem.state == 'canceled' ||
        depositHistoryItem.state == 'rejected') {
      _color = Colors.redAccent.withOpacity(0.75);
      _icon = Icons.close;
    } else if (depositHistoryItem.state == 'accepted' ||
        depositHistoryItem.state == 'skipped' ||
        depositHistoryItem.state == 'collected') {
      _color = Color(0xFF2ebd85);
      _icon = Icons.check;
    }
    String formatedDate =
        DateFormat('yyyy-MM-dd').format(depositHistoryItem.createdAt);
    String formatedTime =
        DateFormat('hh:mm:ss').format(depositHistoryItem.createdAt);
    return InkWell(
      onTap: () {
        HistoryDetail.showDepositHistoryDetail(
            context,
            depositHistoryItem,
            _color,
            _icon,
            formatedDate,
            formatedTime,
            () => handleURLButtonPress(
                depositHistoryItem.currency, depositHistoryItem.txid));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 44.0,
                  width: 44.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(70.0)),
                    border: Border.all(color: _color),
                  ),
                  child: Center(
                    child: Icon(
                      _icon,
                      color: _color,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        formatedDate,
                        style: TextStyle(
                          fontSize: 16.5,
                          fontFamily: "Popins",
                        ),
                      ),
                      Text(
                        formatedTime,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontFamily: "Popins",
                        ),
                      ),
                      // Text(depositHistoryItem.state,
                      //     style:
                      //         TextStyle(fontFamily: "Popins", fontSize: 13.0))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  double.parse(depositHistoryItem.amount).toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 19.5,
                      letterSpacing: 1.6,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w600,
                      color: _color),
                ),
                Text(depositHistoryItem.currency.toUpperCase(),
                    style: TextStyle(
                        letterSpacing: 1.1,
                        fontFamily: "Popins",
                        fontSize: 13.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
