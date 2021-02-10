import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/views/DetailCryptoValue/order_book.dart';
import 'package:crypto_template/views/market/market_drawer.dart';
import 'package:crypto_template/views/trading/limit_order_form.dart';
import 'package:crypto_template/views/trading/market_order_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/views/DetailCryptoValue/openOrders.dart';

class Trading extends StatelessWidget {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final TradingController tradingController =
      Get.put<TradingController>(TradingController());
  final HomeController homeController = Get.find();
  final MarketController marketController = Get.find();

  @override
  Widget build(BuildContext context) {
    final FormatedMarket formatedMarket =
        marketController.selectedMarketTrading.value;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.compare_arrows),
          onPressed: () {
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            } else {
              _scaffoldKey.currentState.openDrawer();
            }
          },
        ),
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        title: GestureDetector(
          onTap: () {
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            } else {
              _scaffoldKey.currentState.openDrawer();
            }
          },
          child: Row(children: [
            Transform(
              transform: Matrix4.translationValues(-8.0, 0.0, 0.0),
              child: Text(
                formatedMarket.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontFamily: "Gotik",
                    fontWeight: FontWeight.w600,
                    fontSize: 18.5),
              ),
            ),
            Text(
              formatedMarket.priceChangePercent,
              style: TextStyle(
                  color: formatedMarket.isPositiveChange
                      ? Color(0xFF00C087)
                      : Colors.redAccent,
                  fontFamily: "Gotik",
                  fontWeight: FontWeight.w600,
                  fontSize: 18.5),
            )
          ]),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1,
      ),
      drawer: Drawer(
        child: MarketDrawer(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                'Order Book',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            OrderBook(
                isTrading: true,
                formatedMarket: formatedMarket,
                asks: marketController.asks.value,
                bids: marketController.bids.value),
            DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          insets:
                              EdgeInsets.only(left: -8, right: 8, bottom: 8)),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 0, right: 16),
                      // indicatorColor:
                      //     Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor:
                          Theme.of(context).textSelectionColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        new Tab(
                          child: Text(
                            "Limit",
                            style: TextStyle(fontFamily: "Sans", fontSize: 14),
                          ),
                        ),
                        new Tab(
                          child: Text(
                            "Market",
                            style: TextStyle(fontFamily: "Sans", fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: homeController.isLoggedIn.value ? 280 : 230,
                    child: TabBarView(children: [
                      LimitOrderForm(formatedMarket: formatedMarket),
                      MarketOrderForm(formatedMarket: formatedMarket),
                    ]),
                  ),
                  if (!homeController.isLoggedIn.value)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 40.0,
                        child: MaterialButton(
                          splashColor: Colors.black12,
                          highlightColor: Colors.black12,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Get.toNamed('/login');
                          },
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Popins",
                                letterSpacing: 1.3,
                                fontSize: 16.0),
                          )),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                'Open Orders',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            OpenOrders(formatedMarket: formatedMarket),
          ],
        ),
      )),
    );
  }
}
