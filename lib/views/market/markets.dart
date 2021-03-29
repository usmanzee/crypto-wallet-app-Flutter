import 'package:b4u_wallet/views/market/market_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Market extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "markets.screen.title".tr,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          elevation: 3.0,
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: MarketList());
  }
}
