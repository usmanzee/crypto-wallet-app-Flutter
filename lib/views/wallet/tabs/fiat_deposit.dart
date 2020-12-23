import 'package:crypto_template/controllers/fiat_deposit_controller.dart';
import 'package:crypto_template/views/wallet/tabs/wallet_amount_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class FiatDeposit extends StatelessWidget {
  final WalletClass.Wallet wallet;
  final FiatDepositController depositController;
  FiatDeposit({this.wallet})
      : depositController =
            Get.put(FiatDepositController(currency: wallet.currency));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          WalletAmountHeader(wallet: wallet),
          SizedBox(
            height: 16.0,
          ),
          Container(
            width: double.infinity,
            // height: 140.0,
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Deposit using bank transfer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Please use the following credentials to initiate your bank transfer. Your deposit will be reflected in your account in minimum 2 hours.',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).hintColor.withOpacity(0.9)),
                      color: Theme.of(context).canvasColor.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.emoji_objects,
                                    size: 15.0,
                                    color: Theme.of(context).errorColor,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'PLEASE USE THE BELOW REFERENCE CODE IN YOUR PAYMENT REFERENCE.',
                                        style: TextStyle(
                                          color: Theme.of(context).errorColor,
                                          fontSize: 10,
                                          fontFamily: "Popins",
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Reference code",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5),
                                      fontFamily: "Popins",
                                      fontSize: 15.5),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  'ID0D2741FBCA',
                                  style: TextStyle(fontFamily: "Popins"),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(0.0),
                                  width: 30.0,
                                  child: IconButton(
                                    icon: Icon(Icons.content_copy),
                                    tooltip: 'Copy Referance Id',
                                    onPressed: () {
                                      Clipboard.setData(new ClipboardData(
                                              text: 'ID0D2741FBCA'))
                                          .then((value) {
                                        Get.snackbar(
                                            'Success', 'Copied to clipboard',
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.grey[900]);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            // child: Wrap(
            //   spacing: 8.0, // gap between adjacent chips
            //   runSpacing: 4.0, // gap between lines
            //   direction: Axis.horizontal, // main axis (rows or columns)
            //   children: <Widget>[
            //     new Chip(label: new Text('Chips11')),
            //     new Chip(label: new Text('Chips12')),
            //     new Chip(label: new Text('Chips13')),
            //     new Chip(label: new Text('Chips14')),
            //     new Chip(label: new Text('Chips15')),
            //     new Chip(label: new Text('Chips16'))
            //   ],
            // )
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bank Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Bank Name",
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 15.5,
                          color: Theme.of(context).hintColor.withOpacity(0.5)),
                    ),
                    Text(
                      'TransferWise',
                      style: TextStyle(
                        fontFamily: "Popins",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Account Holder",
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 15.5,
                          color: Theme.of(context).hintColor.withOpacity(0.5)),
                    ),
                    Flexible(
                      child: Text(
                        'B4U Group of Companies, S.L.',
                        style: TextStyle(
                          fontFamily: "Popins",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Ach Routing Number",
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 15.5,
                          color: Theme.of(context).hintColor.withOpacity(0.5)),
                    ),
                    Text(
                      '026073150',
                      style: TextStyle(
                        fontFamily: "Popins",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Address",
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 15.5,
                          color: Theme.of(context).hintColor.withOpacity(0.5)),
                    ),
                    Flexible(
                      child: Text(
                        'TransferWise 19 W 24th Street New York NY 10010 United States',
                        style: TextStyle(
                          fontFamily: "Popins",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          )
        ],
      ),
    );
  }
}
