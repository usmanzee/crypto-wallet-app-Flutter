import 'package:crypto_template/component/market/btcModel.dart';
import 'package:crypto_template/component/market/usdtModel.dart';
import 'package:crypto_template/screen/crypto_detail_card_homeScreen/DetailCryptoValue/openOrders.dart';
import 'package:crypto_template/screen/crypto_detail_card_homeScreen/DetailCryptoValue/orderHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:crypto_template/component/style.dart';

class usdtDetail extends StatefulWidget {
  final usdtMarket item;

  usdtDetail({Key key, this.item}) : super(key: key);

  _usdtDetailState createState() => _usdtDetailState(item: item);
}

class _usdtDetailState extends State<usdtDetail> {
  usdtMarket item;
  _usdtDetailState({this.item});
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          item.name,
          style: TextStyle(color: Theme.of(context).textSelectionColor),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).hintColor,
        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.priceValue,
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 34.0,
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
                                      style: grayText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  Text("60.8950")
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "Low",
                                      style: grayText,
                                    ),
                                  ),
                                  Text("60.0300")
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
                                item.priceDollar,
                                style: grayText,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  item.percent,
                                  style: TextStyle(color: item.colorChg),
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
                                  style: grayText,
                                ),
                              ),
                              Text("906.8")
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 300.0,
                  child: Stack(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(top:15.0),
                      //   child: _line(),
                      // ),
                      Padding(
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
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 70.0),
                                      child: _line()),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "5000.0000",
                                        style: styleValueChart,
                                      ))
                                ]),
                                Stack(children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 70.0),
                                      child: _line()),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "4000.0000",
                                        style: styleValueChart,
                                      ))
                                ]),
                                Stack(children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 70.0),
                                      child: _line()),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "3000.0000",
                                        style: styleValueChart,
                                      ))
                                ]),
                                Stack(children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 70.0),
                                      child: _line()),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "2000.0000",
                                        style: styleValueChart,
                                      ))
                                ]),
                                Stack(children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 70.0),
                                      child: _line()),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "1000.0000",
                                        style: styleValueChart,
                                      ))
                                ]),
                                Stack(children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 30.0),
                                      child: _line()),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "0.0000",
                                        style: styleValueChart,
                                      ))
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: new Sparkline(
                          data: [
                            0.0,
                            0.5,
                            0.9,
                            1.4,
                            2.2,
                            1.0,
                            3.3,
                            0.0,
                            -0.5,
                            -1.0,
                            -0.5,
                            0.0,
                            0.0
                          ],
                          lineWidth: 0.3,
                          fillMode: FillMode.below,
                          lineColor: Colors.greenAccent,
                          fillGradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.greenAccent.withOpacity(0.2),
                              Colors.greenAccent.withOpacity(0.01)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "50.0000",
                        style: styleValueChart,
                      ),
                      Text(
                        "40.0000",
                        style: styleValueChart,
                      ),
                      Text(
                        "30.0000",
                        style: styleValueChart,
                      ),
                      Text(
                        "20.0000",
                        style: styleValueChart,
                      ),
                      Text(
                        "10.0000",
                        style: styleValueChart,
                      ),
                      Text(
                        "0.0000",
                        style: styleValueChart,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 470.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: new Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(
                                  53.0), // here the desired height
                              child: new AppBar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                elevation: 0.0,
                                centerTitle: true,
                                flexibleSpace: SafeArea(
                                  child: Container(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 100.0),
                                      child: new TabBar(
                                        // labelColor: Theme.of(context).primaryColor,
                                        indicatorColor: colorStyle.primaryColor,
                                        labelColor:
                                            Theme.of(context).primaryColor,
                                        unselectedLabelColor: Theme.of(context)
                                            .textSelectionColor,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        tabs: [
                                          new Tab(
                                            child: Text(
                                              "Open Orders",
                                              style:
                                                  TextStyle(fontFamily: "Sans"),
                                            ),
                                          ),
                                          new Tab(
                                            child: Text(
                                              "Order History",
                                              style:
                                                  TextStyle(fontFamily: "Sans"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                automaticallyImplyLeading: false,
                              ),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: new TabBarView(
                                children: [
                                  openOrders(),
                                  orderHistory(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
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
          )
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 0.2,
      width: double.infinity,
      color: Theme.of(context).hintColor,
    );
  }

  Widget _backgroundLine() {
    return Container(
        height: 13.2,
        width: double.infinity,
        color: Theme.of(context).canvasColor);
  }
}
