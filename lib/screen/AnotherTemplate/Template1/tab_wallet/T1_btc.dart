import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/model_data/Bth_dataModel.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/model_data/Lrm_dataModel.dart';
import 'package:flutter/material.dart';

class T1_btc extends StatefulWidget {
  final Widget child;

  T1_btc({Key key, this.child}) : super(key: key);

  _T1_btcState createState() => _T1_btcState();
}

class _T1_btcState extends State<T1_btc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141C35),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            ///
            /// Credit Card slider
            /// 
            child: CarouselSlider(
              aspectRatio: 5 / 10,
              autoPlay: true,
              viewportFraction: 1.0,
              height: 220.0,
              items: [0, 1, 2, 3, 4].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _cardHeader(listBtc[i]),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Transactions",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.1,
                        fontFamily: "Sans")),
                Container(
                  height: 37.0,
                  width: 105.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(color: Colors.white12)),
                  child: Center(
                    child: Text("View all",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1.1,
                            fontFamily: "Popins")),
                  ),
                )
              ],
            ),
          ),

          ///
          /// List transaction
          ///
          _card(Colors.redAccent.withOpacity(0.75), "06/03/2018", "Confirming",
              "- 0.010", "BTC", Icons.mobile_screen_share),
          _card(Theme.of(context).primaryColor, "03/03/2018", "Completed",
              "+ 0.010", "ETH", Icons.check),
          _card(Theme.of(context).primaryColor, "0/03/2018", "Completed",
              "+ 0.020", "BTC", Icons.check),
        ],
      ),
    );
  }

  ///
  /// Widget card transaction
  ///
  Widget _card(Color _color, String _time, String _info, String _value,
      String _crypto, IconData _icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 44.0,
                width: 44.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(70.0)),
                  border: Border.all(color: _color),
                ),
                child: Center(
                  child: Icon(
                    _icon,
                    color: _color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _time,
                      style: TextStyle(
                          fontSize: 16.5,
                          letterSpacing: 1.2,
                          fontFamily: "Sans"),
                    ),
                    Text(_info,
                        style: TextStyle(
                            color: Colors.white24,
                            letterSpacing: 1.1,
                            fontFamily: "Popins",
                            fontSize: 13.0))
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                _value,
                style: TextStyle(
                    fontSize: 19.5,
                    letterSpacing: 1.6,
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w600,
                    color: _color),
              ),
              Text(_crypto,
                  style: TextStyle(
                      color: Colors.white24,
                      letterSpacing: 1.1,
                      fontFamily: "Popins",
                      fontSize: 13.0))
            ],
          ),
        ],
      ),
    );
  }



  ///
  /// Widget credit card transaction
  ///
  Widget _cardHeader(BtcDataModel item) {
    return Stack(
      children: <Widget>[
        Container(
          height: 220.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF31A1C9), Color(0xFF3DB6D4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w800,
                          fontSize: 30.0,
                          letterSpacing: 1.5,
                          color: Colors.white),
                    ),
                    Text(
                      item.value,
                      style: TextStyle(
                          fontFamily: "Sans",
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          color: Colors.white),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        child: Icon(Icons.account_box, color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.name,
                            style: TextStyle(
                                fontFamily: "Popins",
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            item.id,
                            style: TextStyle(
                                fontFamily: "Popins",
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w300,
                                color: Colors.white30),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 0.2,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Send",
                      style: TextStyle(
                          fontFamily: "Popins",
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Container(
                      height: 15.0,
                      width: 0.5,
                      color: Colors.white,
                    ),
                    Text(
                      "Receive",
                      style: TextStyle(
                          fontFamily: "Popins",
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Container(
                      height: 15.0,
                      width: 0.5,
                      color: Colors.white,
                    ),
                    Text(
                      "Transaction",
                      style: TextStyle(
                          fontFamily: "Popins",
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 170.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200.0),
                    topRight: Radius.circular(20.0))),
          ),
        ),
      ],
    );
  }
}
