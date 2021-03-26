import 'package:crypto_template/component/history_detail.dart';
import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/transaction_history_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/models/withdraw_history_response.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:crypto_template/views/webview_container.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';
import 'package:intl/intl.dart';

class WithdrawHistoryList extends StatelessWidget {
  final WalletClass.Wallet wallet;
  WithdrawHistoryList({this.wallet});

  final TransactionHistoryController transactionHistoryController =
      Get.find<TransactionHistoryController>();
  final WalletController walletController = Get.find<WalletController>();
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
    return Obx(() {
      if (transactionHistoryController.isLoading.value)
        return Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      else
        return transactionHistoryController.withdrawHistory.isEmpty
            ? NoData()
            : Container(
                child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(top: 0.0),
                itemBuilder: (ctx, i) {
                  return _withdrawHistoryList(
                    context,
                    transactionHistoryController.withdrawHistory[i],
                  );
                },
                itemCount: transactionHistoryController.withdrawHistory.length,
              ));
    });
  }

  Widget _withdrawHistoryList(
      BuildContext context, WithdrawHistoryResponse withdrawHistoryItem) {
    Color _color;
    IconData _icon;
    if (withdrawHistoryItem.state == 'canceled' ||
        withdrawHistoryItem.state == 'rejected' ||
        withdrawHistoryItem.state == 'failed' ||
        withdrawHistoryItem.state == 'errored') {
      _color = Colors.redAccent.withOpacity(0.75);
      _icon = Icons.close;
    } else if (withdrawHistoryItem.state == 'accepted' ||
        withdrawHistoryItem.state == 'skipped' ||
        withdrawHistoryItem.state == 'collected' ||
        withdrawHistoryItem.state == 'succeed' ||
        withdrawHistoryItem.state == 'confirming') {
      _color = Color(0xFF2ebd85);
      _icon = Icons.check;
    } else {
      _color = Theme.of(context).accentColor;
      _icon = Icons.autorenew;
    }
    String formatedDate =
        DateFormat('yyyy-MM-dd').format(withdrawHistoryItem.createdAt);
    String formatedTime =
        DateFormat('hh:mm:ss').format(withdrawHistoryItem.createdAt);

    return InkWell(
      onTap: () {
        HistoryDetail.showWithdrawlHistoryDetail(
            context,
            withdrawHistoryItem,
            _color,
            _icon,
            formatedDate,
            formatedTime,
            () => handleURLButtonPress(withdrawHistoryItem.currency,
                withdrawHistoryItem.blockchainTxid));
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
                      // Text(withdrawHistoryItem.state,
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
                  double.parse(withdrawHistoryItem.amount).toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 19.5,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w600,
                      color: _color),
                ),
                Text(withdrawHistoryItem.currency.toUpperCase(),
                    style: TextStyle(fontFamily: "Popins", fontSize: 13.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
