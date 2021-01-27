import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/market_detail_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/views/DetailCryptoValue/openOrders.dart';
import 'package:crypto_template/views/DetailCryptoValue/order_book.dart';
import 'package:crypto_template/views/market/market_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';

class MarketDetail extends GetWidget<MarketDetailController> {
  // final FormatedMarket formatedMarket = Get.arguments['formatedMarket'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  MarketController marketController = Get.find();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // final FormatedMarket formatedMarket = controller.market.value;
      final FormatedMarket formatedMarket =
          marketController.selectedMarket.value;
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).canvasColor,
          title: GestureDetector(
            onTap: () {
              if (_scaffoldKey.currentState.isDrawerOpen) {
                _scaffoldKey.currentState.openEndDrawer();
              } else {
                _scaffoldKey.currentState.openDrawer();
              }
            },
            child: Row(children: [
              Text(
                formatedMarket.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor, fontSize: 18),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 24,
                color: Theme.of(context).textSelectionColor,
              )
            ]),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionColor,
          ),
        ),
        drawer: Drawer(
          child: MarketDrawer(screen: 'market_detail'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 15.0, right: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _headerValue(context, formatedMarket),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.1)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: DefaultTabController(
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
                                  insets: EdgeInsets.only(
                                      left: -8, right: 8, bottom: 8)),
                              isScrollable: true,
                              labelPadding: EdgeInsets.only(left: 0, right: 16),
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor:
                                  Theme.of(context).textSelectionColor,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: [
                                new Tab(
                                  child: Text(
                                    "Line",
                                    style: TextStyle(
                                        fontFamily: "Sans", fontSize: 14),
                                  ),
                                ),
                                new Tab(
                                  child: Text(
                                    "Depth",
                                    style: TextStyle(
                                        fontFamily: "Sans", fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 320,
                            child: TabBarView(children: [
                              Obx(() {
                                if (controller.isKLineLoading.value) {
                                  return Container(
                                      width: double.infinity,
                                      height: 200,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator());
                                } else {
                                  return Column(children: [
                                    loadGraphOption(
                                        context,
                                        controller.lineGraphTimeSlots.value,
                                        controller.selectedOption.value),
                                    Container(
                                      height: 200,
                                      child: KChartWidget(
                                        controller.formatedKLineData,
                                        isLine: controller.isLine,
                                        mainState: controller.mainState,
                                        volHidden: controller.volHidden,
                                        secondaryState:
                                            controller.secondaryState,
                                        fixedLength: 2,
                                        timeFormat: TimeFormat.YEAR_MONTH_DAY,
                                        isChinese: false,
                                        bgColor: [
                                          Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ],
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        height: 40.0,
                                        child: buildGraphTypeButtons(context)),
                                  ]);
                                }
                              }),
                              Container(
                                height: 200,
                                width: double.infinity,
                                child: DepthChart(controller.bidsData.value,
                                    controller.asksData.value),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 400.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                        //   child: Text(
                        //     'Open Orders',
                        //     style: TextStyle(
                        //         fontSize: 16, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // OpenOrders(
                        //   formatedMarket: formatedMarket,
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            'Order Book',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        OrderBook(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buttonBottom(context, formatedMarket)
          ],
        ),
      );
    });
  }

  Widget _headerValue(context, FormatedMarket formatedMarket) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              formatedMarket.last
                  .toStringAsFixed(formatedMarket.amountPrecision),
              style: TextStyle(
                  color: formatedMarket.isPositiveChange
                      ? Color(0xFF00C087)
                      : Colors.redAccent,
                  fontSize: 36.0,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "High",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins",
                            fontSize: 11.5),
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text(formatedMarket.high
                        .toStringAsFixed(formatedMarket.amountPrecision))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "Low",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins",
                            fontSize: 11.5),
                      ),
                    ),
                    Text(formatedMarket.low
                        .toStringAsFixed(formatedMarket.amountPrecision))
                  ],
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "\$60.57000",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: "Popins",
                      fontSize: 11.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    formatedMarket.priceChangePercent,
                    style: TextStyle(
                      color: formatedMarket.isPositiveChange
                          ? Color(0xFF00C087)
                          : Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 31.0),
                  child: Text(
                    "24h Vol",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                ),
                Text(formatedMarket.high
                    .toStringAsFixed(formatedMarket.amountPrecision))
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget loadGraphOption(context, var lineGraphTimeSlots, var selectedOption) {
    return Container(
      height: 40,
      child: Column(children: [
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: lineGraphTimeSlots.length,
              itemBuilder: (BuildContext context, int index) => Card(
                child: InkWell(
                  onTap: () {
                    controller.selectedOption.value = lineGraphTimeSlots[index];
                    controller.getKlineData();
                  },
                  child: Container(
                    width: 50,
                    color: selectedOption['key'] ==
                            lineGraphTimeSlots[index]['key']
                        ? Theme.of(context).accentColor
                        : Theme.of(context).canvasColor,
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        lineGraphTimeSlots[index]['key'],
                        style: TextStyle(
                            fontSize: 10,
                            color: selectedOption['key'] ==
                                    lineGraphTimeSlots[index]['key']
                                ? Colors.white
                                : Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildGraphTypeButtons(context) {
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          button(context, "Time sharing",
              onPressed: () => controller.isLine = true),
          button(context, "k line", onPressed: () => controller.isLine = false),
          button(context, "MA",
              onPressed: () => controller.mainState = MainState.MA),
          button(context, "BOLL",
              onPressed: () => controller.mainState = MainState.BOLL),
          button(context, "hide",
              onPressed: () => controller.mainState = MainState.NONE),
          button(context, "MACD",
              onPressed: () => controller.secondaryState = SecondaryState.MACD),
          button(context, "KDJ",
              onPressed: () => controller.secondaryState = SecondaryState.KDJ),
          button(context, "RSI",
              onPressed: () => controller.secondaryState = SecondaryState.RSI),
          button(context, "WR",
              onPressed: () => controller.secondaryState = SecondaryState.WR),
          button(context, "Hide side view",
              onPressed: () => controller.secondaryState = SecondaryState.NONE),
          button(context, controller.volHidden ? "Show volume" : "Hide volume",
              onPressed: () => controller.volHidden = !controller.volHidden),
        ],
      ),
    );
  }

  Widget button(context, String text, {VoidCallback onPressed}) {
    return Card(
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        child: Container(
          width: 50,
          padding: EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buttonBottom(context, FormatedMarket formatedMarket) {
  HomeController homeController = Get.find();
  MarketController marketController = Get.find();
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 50.0,
          width: 160.0,
          child: MaterialButton(
            splashColor: Colors.black12,
            highlightColor: Colors.black12,
            color: Color(0xFF00C087),
            onPressed: () {
              Get.back();
              marketController.selectedMarketTrading.value = formatedMarket;
              homeController.selectedNavIndex = 2;
              // Get.offNamed('/trading', arguments: {
              //   'formatedMarket': formatedMarket,
              //   'selectedNavIndex': 3
              // });
            },
            child: Center(
                child: Text(
              "Buy",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Popins",
                  letterSpacing: 1.3,
                  fontSize: 16.0),
            )),
          ),
        ),
        SizedBox(
          width: 0.0,
        ),
        Container(
          height: 50.0,
          width: 160.0,
          child: MaterialButton(
            splashColor: Colors.black12,
            highlightColor: Colors.black12,
            color: Colors.redAccent.withOpacity(0.8),
            onPressed: () {
              Get.back();
              marketController.selectedMarketTrading.value = formatedMarket;
              homeController.selectedNavIndex = 2;
              // Get.offNamed('/trading', arguments: {
              //   'formatedMarket': formatedMarket,
              //   'selectedNavIndex': 3
              // });
            },
            child: Center(
                child: Text(
              "Sell",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Popins",
                  letterSpacing: 1.3,
                  fontSize: 16.0),
            )),
          ),
        ),
      ],
    ),
  );
}
