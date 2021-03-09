import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/transaction_history_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/models/deposit_histroy.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:crypto_template/views/webview_container.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';
import 'package:intl/intl.dart';

class DepositHistoryList extends StatelessWidget {
  final WalletClass.Wallet wallet;
  DepositHistoryList({this.wallet});

  final TransactionHistoryController transactionHistoryController =
      Get.find<TransactionHistoryController>();
  final WalletController walletController = Get.find<WalletController>();
  void _handleURLButtonPress(String currency, String txid) {
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
        return transactionHistoryController.depositHistory.isEmpty
            ? NoData()
            : Container(
                child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(top: 0.0),
                itemBuilder: (ctx, i) {
                  return _depositHistoryList(
                    context,
                    transactionHistoryController.depositHistory[i],
                  );
                },
                itemCount: transactionHistoryController.depositHistory.length,
              ));
    });
  }

  Widget _depositHistoryList(
      BuildContext context, DepositHistory depositHistoryItem) {
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
        _depositHistoryDetail(context, depositHistoryItem, _color, _icon,
            formatedDate, formatedTime);
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
                      Text(depositHistoryItem.state,
                          style:
                              TextStyle(fontFamily: "Popins", fontSize: 13.0))
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
                  depositHistoryItem.amount,
                  style: TextStyle(
                      fontSize: 19.5,
                      letterSpacing: 1.6,
                      fontFamily: "Sans",
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

  void _depositHistoryDetail(context, DepositHistory depositHistoryItem,
      Color _color, IconData _icon, String formatedDate, String formatedTime) {
    bool isButtonEnabled =
        depositHistoryItem.txid != null && depositHistoryItem.txid != '';
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: new Wrap(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: wallet.iconUrl != null
                          ? Image.network(
                              wallet.iconUrl,
                              height: 25.0,
                              fit: BoxFit.contain,
                              width: 25.0,
                            )
                          : Image.asset(
                              'assets/image/market/BCH.png',
                              height: 25.0,
                              fit: BoxFit.contain,
                              width: 25.0,
                            ),
                    ),
                    Text(
                      wallet.currency.toUpperCase(),
                      style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        letterSpacing: 1.5,
                        // color: Colors.white
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Amount",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      depositHistoryItem.amount,
                      style: TextStyle(fontFamily: "Popins"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Status",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      depositHistoryItem.state,
                      style: TextStyle(fontFamily: "Popins"),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration:
                        BoxDecoration(color: Theme.of(context).hintColor),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       "Address",
                //       style: TextStyle(
                //           color: Theme.of(context).hintColor.withOpacity(0.5),
                //           fontFamily: "Popins",
                //           fontSize: 15.5),
                //     ),
                //     Text(
                //       depositHistoryItem.confirmations.toString(),
                //       style: TextStyle(fontFamily: "Popins"),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Transaction Fee",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      depositHistoryItem.fee,
                      style: TextStyle(fontFamily: "Popins"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "TxID",
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        depositHistoryItem.txid,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "Popins"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Date",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      formatedDate + ' ' + formatedTime,
                      style: TextStyle(fontFamily: "Popins"),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RawMaterialButton(
                        disabledElevation: 1,
                        fillColor: isButtonEnabled
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.5),
                        onPressed: isButtonEnabled
                            ? () =>
                                Helper.copyToClipBoard(depositHistoryItem.txid)
                            : null,
                        child: Center(
                            child: Text(
                          "Copy TxID",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RawMaterialButton(
                        disabledElevation: 1,
                        fillColor: isButtonEnabled
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.5),
                        onPressed: isButtonEnabled
                            ? () => _handleURLButtonPress(
                                wallet.currency, depositHistoryItem.txid)
                            : null,
                        child: Center(
                            child: Text(
                          "Check Explorer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
