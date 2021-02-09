import 'package:crypto_template/views/market/market_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Market extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            "Market",
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          elevation: 3.0,
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: MarketList());
  }
}
