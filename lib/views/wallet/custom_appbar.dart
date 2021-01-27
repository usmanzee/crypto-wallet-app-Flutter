import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;

class WalletCustomAppbar extends StatelessWidget {
  final String title;
  final String screenType;
  final WalletClass.Wallet wallet;
  WalletCustomAppbar({this.title, this.screenType, this.wallet});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).textSelectionColor,
            fontFamily: "Gotik",
            fontWeight: FontWeight.w600,
            fontSize: 18.5),
      ),
      centerTitle: true,
      flexibleSpace: GestureDetector(
        onTap: () {
          Get.offNamed('/wallets-search',
              arguments: {'searchFrom': screenType});
        },
        child: Padding(
            padding: EdgeInsets.only(top: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 10),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(16),
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
                                  height: 30.0,
                                  fit: BoxFit.contain,
                                  width: 30.0,
                                )
                              : Image.asset(
                                  'assets/image/market/BCH.png',
                                  height: 30.0,
                                  fit: BoxFit.contain,
                                  width: 30.0,
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
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 20.0,
                    ),
                  ],
                ),
              ))
            ])),
      ),
      iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
      elevation: 1.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
