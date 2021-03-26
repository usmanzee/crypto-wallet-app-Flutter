import 'package:crypto_template/models/deposit_histroy_response.dart';
import 'package:crypto_template/models/withdraw_history_response.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryDetail {
  static void showDepositHistoryDetail(
      BuildContext context,
      DepositHistoryResponse depositHistoryItem,
      Color color,
      IconData icon,
      String formatedDate,
      String formatedTime,
      VoidCallback openExploredLink) {
    bool isButtonEnabled =
        depositHistoryItem.txid != null && depositHistoryItem.txid != '';
    Get.bottomSheet(Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
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
                depositHistoryItem.amount,
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
                depositHistoryItem.currency.toUpperCase(),
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
                  border: Border.all(color: color),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 14,
                    color: color,
                  ),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                depositHistoryItem.state,
                style: TextStyle(
                    fontFamily: "Popins", fontSize: 18.0, color: color),
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
              decoration: BoxDecoration(color: Theme.of(context).hintColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
                  "wallet_deposit_history.screen.transaction_fee".tr,
                  style: TextStyle(
                      color: Theme.of(context).hintColor.withOpacity(0.5),
                      fontFamily: "Popins",
                      fontSize: 15.5),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  depositHistoryItem.fee,
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
                  "wallet_deposit_history.screen.txid".tr,
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
                    depositHistoryItem.txid,
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
                  "wallet_deposit_history.screen.date".tr,
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
                      ? () => Helper.copyToClipBoard(depositHistoryItem.txid)
                      : null,
                  child: Center(
                      child: Text(
                    "wallet_deposit_history.screen.button.copy_txid".tr,
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
                  onPressed: isButtonEnabled ? openExploredLink : null,
                  child: Center(
                      child: Text(
                    "wallet_deposit_history.screen.button.check_explorer".tr,
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
    ));
  }

  static void showWithdrawlHistoryDetail(
      BuildContext context,
      WithdrawHistoryResponse withdrawHistoryItem,
      Color color,
      IconData icon,
      String formatedDate,
      String formatedTime,
      VoidCallback openExploredLink) {
    bool isButtonEnabled = withdrawHistoryItem.blockchainTxid != null &&
        withdrawHistoryItem.blockchainTxid != '';
    Get.bottomSheet(Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: ListView(
        shrinkWrap: true,
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
                  border: Border.all(color: color),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 14,
                    color: color,
                  ),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                withdrawHistoryItem.state,
                style: TextStyle(
                    fontFamily: "Popins", fontSize: 18.0, color: color),
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
              decoration: BoxDecoration(color: Theme.of(context).hintColor),
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
                  onPressed: isButtonEnabled ? openExploredLink : null,
                  child: Center(
                      child: Text(
                    "wallet_withdraw_history.screen.button.check_explorer".tr,
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
    ));
  }
}
