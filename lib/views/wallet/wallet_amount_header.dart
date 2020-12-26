import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;

class WalletAmountHeader extends StatelessWidget {
  final WalletClass.Wallet wallet;

  WalletAmountHeader({this.wallet});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 140.0,
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
          // color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total",
                style: TextStyle(
                    color: Theme.of(context).hintColor.withOpacity(0.5),
                    fontFamily: "Popins",
                    fontSize: 15.5),
              ),
              Text(
                (double.parse(wallet.balance) + double.parse(wallet.locked))
                    .toStringAsFixed(wallet.precision),
                style: TextStyle(fontFamily: "Popins"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Available",
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
          Row(
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
        ],
      ),
    );
  }
}
