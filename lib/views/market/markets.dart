import 'package:crypto_template/screen/market/TabBarBody/btc.dart';
import 'package:crypto_template/screen/market/TabBarBody/eth.dart';
import 'package:crypto_template/screen/market/TabBarBody/favorite.dart';
import 'package:crypto_template/screen/market/TabBarBody/usdt.dart';
import 'package:crypto_template/screen/market/TabBarBody/xrp.dart';
import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  final Widget child;

  Market({Key key, this.child}) : super(key: key);

  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this, initialIndex: 1);
    super.initState();
  }

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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.search,
              color: Theme.of(context).textSelectionColor,
            ),
          ),
        ],
        elevation: 3.0,
        backgroundColor: Theme.of(context).canvasColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).textSelectionColor,
          tabs: <Widget>[
            new Tab(
              child: Text(
                "FAV",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "BTC",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "USDT",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "XRP",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "ETH",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[favorite(), btc(), usdt(), xrp(), eth()],
        controller: _tabController,
      ),
    );
  }
}
