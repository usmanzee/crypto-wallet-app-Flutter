import 'package:crypto_template/component/modelGridHome.dart';
import 'package:crypto_template/controllers/market_detail_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/screen/crypto_detail_card_homeScreen/DetailCryptoValue/openOrders.dart';
import 'package:crypto_template/screen/crypto_detail_card_homeScreen/DetailCryptoValue/orderHistory.dart';
import 'package:crypto_template/views/market/market_detail_graph.dart';
import 'package:crypto_template/views/market/market_drawer.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/component/style.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:get/get.dart';

// class MarketDetail extends StatefulWidget {
//   final gridHome item;
//   final FormatedMarket formatedMarket;

//   MarketDetail({Key key, this.item, this.formatedMarket}) : super(key: key);

//   _MarketDetailState createState() => _MarketDetailState(item, formatedMarket);
// }

class MarketDetail extends StatelessWidget {
  final gridHome item;
  final FormatedMarket formatedMarket;

  final MarketDetailController marketDetailController;
  MarketDetail({this.item, this.formatedMarket})
      : marketDetailController =
            Get.put(MarketDetailController(formatedMarket: formatedMarket));
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var grayText = TextStyle(
        color: Theme.of(context).hintColor,
        fontFamily: "Popins",
        fontSize: 12.5);

    var styleValueChart = TextStyle(
        color: Theme.of(context).hintColor,
        fontFamily: "Popins",
        fontSize: 11.5);
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
              Icons.keyboard_arrow_down,
              size: 24,
              color: Theme.of(context).accentColor,
            )
          ]),
        ),
        // leadingWidth: 24,
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
        child: MarketDrawer(),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _headerValue(context),
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
                Obx(() => loadGraphOption(
                    context,
                    marketDetailController.graphTypes.value,
                    marketDetailController.selectedGraph.value,
                    marketDetailController.selectedOption.value)),
                Container(
                  height: 300.0,
                  child: Stack(
                    children: <Widget>[
                      // _verticalValueGrafik(),
                      // _horizontalValueGrafik(),
                      Obx(() => MarketDetailGraph(
                            selectedGraph:
                                marketDetailController.selectedGraph.value,
                          ))
                      // _sparkLineGrafic(),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                ///
                /// Container for tab bar (open orders) and body value
                ///

                buildButtons(context),
                Container(
                  height: 470.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(
                          'Open Orders',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      openOrders(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buttonBottom(context)
        ],
      ),
    );
  }

  Widget loadGraphOption(
      context, var graphTypes, var selectedGraph, var selectedOption) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          height: 60,
          child: Column(children: [
            Row(
              children: graphTypes.map<Widget>((graphType) {
                return Row(children: [
                  InkWell(
                    onTap: () {
                      marketDetailController.selectedGraph.assignAll(graphType);
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        color: graphType['name'] == selectedGraph['name']
                            ? Theme.of(context).accentColor
                            : Theme.of(context).scaffoldBackgroundColor,
                      ),
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Row(children: [
                          Text(
                            graphType['name'],
                            style: TextStyle(
                              color: graphType['name'] == selectedGraph['name']
                                  ? Colors.white
                                  : Theme.of(context).textSelectionColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: graphType['name'] == selectedGraph['name']
                                ? Colors.white
                                : Theme.of(context).textSelectionColor,
                            size: 14,
                          )
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                ]);
              }).toList(),
            ),
            SizedBox(
              height: 8,
            ),
            if (selectedGraph['options'].length > 0)
              Expanded(
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedGraph['options'].length,
                    itemBuilder: (BuildContext context, int index) => Card(
                      child: InkWell(
                        onTap: () {
                          marketDetailController.selectedOption.value =
                              selectedGraph['options'][index]['key'];
                        },
                        child: Container(
                          width: 50,
                          color: selectedOption ==
                                  selectedGraph['options'][index]['key']
                              ? Theme.of(context).accentColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                            child: Text(
                              selectedGraph['options'][index]['key'],
                              style: TextStyle(
                                  fontSize: 10,
                                  color: selectedOption ==
                                          selectedGraph['options'][index]['key']
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
            // Wrap(spacing: 8, runSpacing: 8, children: [
            //   for (var option in selectedGraph['options'])
            //     InkWell(
            //       onTap: () {
            //         // setState(() {
            //         //   selectedOption = option;
            //         // });
            //       },
            //       child: Container(
            //         width: 50,
            //         color: selectedOption == option
            //             ? Theme.of(context).accentColor
            //             : Theme.of(context).canvasColor,
            //         padding: EdgeInsets.all(4.0),
            //         child: Center(
            //           child: Text(
            //             option,
            //             style: TextStyle(
            //                 fontSize: 10,
            //                 color: selectedOption == option
            //                     ? Colors.white
            //                     : Theme.of(context).textSelectionColor,
            //                 fontWeight: FontWeight.w500),
            //           ),
            //         ),
            //       ),
            //     ),
            // ]),
          ])),
    );
  }

  Widget _buttonBottom(context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 140.0,
            child: MaterialButton(
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              color: Colors.greenAccent.withOpacity(0.8),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Tap'),
                ));
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
            width: 140.0,
            child: MaterialButton(
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              color: Colors.redAccent.withOpacity(0.8),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Tap'),
                ));
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
          Column(children: <Widget>[
            Icon(
              Icons.star,
              color: Theme.of(context).hintColor,
            ),
            Container(
                width: 50.0,
                child: Center(
                    child: Text(
                  "Add to Favorites",
                  style: TextStyle(
                      fontSize: 10.0, color: Theme.of(context).hintColor),
                  textAlign: TextAlign.center,
                )))
          ])
        ],
      ),
    );
  }

  Widget _tabBarCustomButton(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(53.0), // here the desired height
      child: new AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 100.0),
              child: new TabBar(
                // labelColor: Theme.of(context).primaryColor,
                indicatorColor: colorStyle.primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).textSelectionColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  new Tab(
                    child: Text(
                      "Open Orders",
                      style: TextStyle(fontFamily: "Sans"),
                    ),
                  ),
                  new Tab(
                    child: Text(
                      "Order History",
                      style: TextStyle(fontFamily: "Sans"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _headerValue(context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              formatedMarket.last.toString(),
              style: TextStyle(
                  color: formatedMarket.isPositiveChange
                      ? Colors.greenAccent
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
                    Text(formatedMarket.high.toString())
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
                    Text(formatedMarket.low.toString())
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
                          ? Colors.greenAccent
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
                Text(formatedMarket.high.toString())
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _sparkLineGrafic() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: new Sparkline(
        data: item.data,
        lineWidth: 0.3,
        fillMode: FillMode.below,
        lineColor: item.chartColor,
        fillGradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: item.chartColorGradient,
        ),
      ),
    );
  }

  Widget _horizontalValueGrafik(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "50.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "40.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "30.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "20.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "10.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "0.0000",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _verticalValueGrafik(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line(context)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "5000.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line(context)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "4000.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line(context)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "3000.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line(context)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "2000.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line(context)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "1000.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 30.0),
                    child: _line(context)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "0.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line(context) {
    return Container(
      height: 0.2,
      width: double.infinity,
      color: Theme.of(context).hintColor,
    );
  }

  Widget _backgroundLine(context) {
    return Container(
        height: 13.2,
        width: double.infinity,
        color: Theme.of(context).canvasColor);
  }
}

Widget buildButtons(context) {
  return Wrap(
    alignment: WrapAlignment.spaceEvenly,
    children: <Widget>[
      button(
        context,
        "Time sharing",
      ),
      button(
        context,
        "k line",
      ),
      button(
        context,
        "MA",
      ),
      button(
        context,
        "BOLL",
      ),
      button(
        context,
        "hide",
      ),
      button(
        context,
        "MACD",
      ),
      button(
        context,
        "KDJ",
      ),
      button(
        context,
        "RSI",
      ),
      button(
        context,
        "WR",
      ),
      button(
        context,
        "Hide side view",
      ),
      button(
        context,
        "Show volume",
      ),
      button(
        context,
        "切换中英文",
      ),
    ],
  );
}

Widget button(context, String text, {VoidCallback onPressed}) {
  return FlatButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text("$text"),
      color: Theme.of(context).canvasColor);
}
