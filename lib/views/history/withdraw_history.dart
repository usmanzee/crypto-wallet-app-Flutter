import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/history_controller.dart';
import 'package:crypto_template/models/withdraw_history_response.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WithdrawHistory extends StatelessWidget {
  final blockChainLink;
  WithdrawHistory({this.blockChainLink});
  final HistoryController historyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (historyController.isWithdrawHistoryLoading.value)
        return Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      else
        return historyController.withdrawHistory.isEmpty
            ? NoData()
            : Container(
                child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(top: 0.0),
                itemBuilder: (ctx, i) {
                  return _withdrawHistoryList(
                    context,
                    historyController.withdrawHistory[i],
                  );
                },
                itemCount: historyController.withdrawHistory.length,
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
        _withdrawHistoryDetail(context, withdrawHistoryItem, _color, _icon,
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
                  withdrawHistoryItem.amount,
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

  void _withdrawHistoryDetail(
      context,
      WithdrawHistoryResponse withdrawHistoryItem,
      Color _color,
      IconData _icon,
      String formatedDate,
      String formatedTime) {
    bool isButtonEnabled = withdrawHistoryItem.blockchainTxid != null &&
        withdrawHistoryItem.blockchainTxid != '';
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: new Wrap(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Center(
                      child: Text(
                        "wallet_deposit_history.screen.amount".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      withdrawHistoryItem.amount,
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      withdrawHistoryItem.currency.toUpperCase(),
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(70.0)),
                        border: Border.all(color: _color),
                      ),
                      child: Center(
                        child: Icon(
                          _icon,
                          size: 14,
                          color: _color,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      withdrawHistoryItem.state,
                      style: TextStyle(
                          fontFamily: "Popins", fontSize: 18.0, color: _color),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text(
                        "wallet_withdraw_history.screen.address".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          withdrawHistoryItem.rid,
                          style: TextStyle(fontFamily: "Popins"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text(
                        "wallet_withdraw_history.screen.transaction_fee".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        withdrawHistoryItem.fee,
                        style: TextStyle(fontFamily: "Popins"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text(
                        "wallet_withdraw_history.screen.txid".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          (withdrawHistoryItem.blockchainTxid != null &&
                                  withdrawHistoryItem.blockchainTxid != ''
                              ? withdrawHistoryItem.blockchainTxid
                              : '---'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: "Popins"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text(
                        "wallet_withdraw_history.screen.date".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        formatedDate + ' ' + formatedTime,
                        style: TextStyle(fontFamily: "Popins"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RawMaterialButton(
                        disabledElevation: 1,
                        fillColor: isButtonEnabled
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.5),
                        onPressed: isButtonEnabled
                            ? () => Helper.copyToClipBoard(
                                withdrawHistoryItem.blockchainTxid)
                            : null,
                        child: Center(
                            child: Text(
                          "wallet_withdraw_history.screen.button.copy_txid".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                      ),
                      RawMaterialButton(
                        disabledElevation: 1,
                        fillColor: isButtonEnabled
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.5),
                        onPressed: isButtonEnabled
                            ? () => blockChainLink(withdrawHistoryItem.currency,
                                withdrawHistoryItem.blockchainTxid)
                            : null,
                        child: Center(
                            child: Text(
                          "wallet_withdraw_history.screen.button.check_explorer"
                              .tr,
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
