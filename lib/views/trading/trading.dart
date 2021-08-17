import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/trading_controller.dart';
import 'package:b4u_wallet/views/DetailCryptoValue/order_book.dart';
import 'package:b4u_wallet/views/market/market_drawer.dart';
import 'package:b4u_wallet/views/trading/limit_order_form.dart';
import 'package:b4u_wallet/views/trading/market_order_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/views/DetailCryptoValue/open_orders.dart';

class Trading extends StatelessWidget {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final TradingController tradingController =
      Get.put<TradingController>(TradingController());
  final HomeController homeController = Get.find();
  final MarketController marketController = Get.find();

  @override
  Widget build(BuildContext context) {
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
                marketController.selectedMarketTrading.value.name != null
                    ? marketController.selectedMarketTrading.value.name
                        .toUpperCase()
                    : '--',
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontFamily: "Gotik",
                    fontWeight: FontWeight.w600,
                    fontSize: 18.5),
              ),
            ),
            Text(
              marketController.selectedMarketTrading.value.priceChangePercent !=
                      null
                  ? marketController
                      .selectedMarketTrading.value.priceChangePercent
                  : '',
              style: TextStyle(
                  color: marketController
                              .selectedMarketTrading.value.isPositiveChange !=
                          null
                      ? marketController
                              .selectedMarketTrading.value.isPositiveChange
                          ? Color(0xFF00C087)
                          : Colors.redAccent
                      : Theme.of(context).scaffoldBackgroundColor,
                  fontFamily: "Gotik",
                  fontWeight: FontWeight.w600,
                  fontSize: 18.5),
            )
          ]),
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.selectionColor),
        elevation: 0,
      ),
      drawer: Drawer(
        child: MarketDrawer(),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  marketController.selectedMarketTrading.value.last != null
                      ? marketController.selectedMarketTrading.value.last
                          .toStringAsFixed(2)
                      : '--',
                  style: TextStyle(
                      color: marketController.selectedMarketTrading.value
                                  .isPositiveChange !=
                              null
                          ? marketController
                                  .selectedMarketTrading.value.isPositiveChange
                              ? Color(0xFF00C087)
                              : Colors.redAccent
                          : Theme.of(context).hintColor,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5),
                ),
                Text(
                  ' ≈ \$',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5),
                ),
                Text(
                  marketController.selectedMarketTrading.value.priceInUsd !=
                          null
                      ? marketController.selectedMarketTrading.value.priceInUsd
                      : '--',
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  margin: const EdgeInsets.only(top: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).hintColor,
                          offset: Offset(0.0, 0.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Theme.of(context).scaffoldBackgroundColor),
                  child: OrderBook(
                      isTrading: true,
                      formatedMarket:
                          marketController.selectedMarketTrading.value,
                      asks: marketController.asks,
                      bids: marketController.bids),
                ),
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            insets:
                                EdgeInsets.only(left: -8, right: 8, bottom: 8),),
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(left: 0, right: 16),
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          new Tab(
                            child: Text(
                              "trading.screen.p2p_buy_sell_tabs.limit".tr,
                              style:
                                  TextStyle(fontFamily: "Popins", fontSize: 14),
                            ),
                          ),
                          new Tab(
                            child: Text(
                              "trading.screen.p2p_buy_sell_tabs.market".tr,
                              style:
                                  TextStyle(fontFamily: "Popins", fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: homeController.isLoggedIn.value ? 300 : 250,
                      child: TabBarView(children: [
                        LimitOrderForm(
                          formatedMarket:
                              marketController.selectedMarketTrading.value,
                        ),
                        MarketOrderForm(
                            formatedMarket:
                                marketController.selectedMarketTrading.value),
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
              OpenOrders(
                  formatedMarket: marketController.selectedMarketTrading.value),
            ]),
          ),
        ],
      )),
    );
  }
}
