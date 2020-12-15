import 'package:crypto_template/controllers/WalletController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:crypto_template/models/DepositAddress.dart';
import 'package:qr_flutter/qr_flutter.dart';

// class deposit extends StatefulWidget {
//   final Widget child;

//   deposit({Key key, this.child}) : super(key: key);

//   _depositState createState() => _depositState();
// }

class Deposit extends StatelessWidget {
  final WalletClass.Wallet wallet;
  final WalletController walletController = Get.find();
  Deposit({this.wallet});
  @override
  Widget build(BuildContext context) {
    walletController.fetchDepositAddress(wallet.currency);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 140.0,
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total",
                        // "Value (USDT)",
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                      Text(
                        (double.parse(wallet.balance) +
                                double.parse(wallet.locked))
                            .toStringAsFixed(wallet.precision),
                        style: TextStyle(fontFamily: "Popins"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Available",
                        // "Available (BCH)",
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                      Text(
                        wallet.balance,
                        style: TextStyle(fontFamily: "Popins"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Locked",
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.5),
                            fontFamily: "Popins",
                            fontSize: 15.5),
                      ),
                      Text(
                        wallet.locked,
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 125.0,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Obx(() {
              if (walletController.isAddressLoading.value)
                return CircularProgressIndicator();
              else
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      walletController.depositAddress.value,
                      style: TextStyle(
                        color: Theme.of(context).hintColor.withOpacity(0.7),
                        fontFamily: "Popins",
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 150.0,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          "COPY ADDRESS",
                          style: TextStyle(
                              color: Theme.of(context).textSelectionColor),
                        ),
                      ),
                    )
                  ],
                );
            }),
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: <Widget>[
              Obx(() {
                if (walletController.isAddressLoading.value)
                  return CircularProgressIndicator();
                else
                  return QrImage(
                      data: walletController.depositAddress.value,
                      version: QrVersions.auto,
                      size: 210.0,
                      backgroundColor: Colors.white);
              }),
              SizedBox(
                height: 20.0,
              ),
              // Image.asset(
              //   "assets/image/qrCode.png",
              //   height: 210.0,
              // ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 40.0,
                width: 150.0,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    "SAVE IMAGE",
                    style:
                        TextStyle(color: Theme.of(context).textSelectionColor),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
