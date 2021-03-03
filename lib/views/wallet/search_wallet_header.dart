import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;

class SearchHeader extends StatelessWidget {
  final String screenType;
  final WalletClass.Wallet wallet;
  SearchHeader({this.screenType, this.wallet});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed('/wallets-search', arguments: {'searchFrom': screenType});
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          color: Theme.of(context).canvasColor,
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                      letterSpacing: 1.5,
                    ),
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 20.0,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
