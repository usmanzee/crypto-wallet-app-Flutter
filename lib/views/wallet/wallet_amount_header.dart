import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';

class WalletAmountHeader extends StatelessWidget {
  final WalletClass.Wallet wallet;

  WalletAmountHeader({this.wallet});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "wallet_detail.screen.total".tr,
                style: TextStyle(
                    color: Theme.of(context).hintColor.withOpacity(0.5),
                    fontFamily: "Popins",
                    fontSize: 15.5),
              ),
              Text(
                (double.parse(wallet.balance) + double.parse(wallet.locked))
                    .toStringAsFixed(wallet.precision),
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Popins"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "wallet_detail.screen.available".tr,
                style: TextStyle(
                    color: Theme.of(context).hintColor.withOpacity(0.5),
                    fontFamily: "Popins",
                    fontSize: 15.5),
              ),
              Text(
                wallet.balance,
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Popins"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "wallet_detail.screen.locked".tr,
                style: TextStyle(
                    color: Theme.of(context).hintColor.withOpacity(0.5),
                    fontFamily: "Popins",
                    fontSize: 15.5),
              ),
              Text(
                wallet.locked,
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
