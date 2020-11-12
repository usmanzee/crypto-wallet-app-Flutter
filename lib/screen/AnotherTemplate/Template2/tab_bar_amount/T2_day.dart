import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class T2_day_tab extends StatefulWidget {
  T2_day_tab({Key key}) : super(key: key);

  _T2_day_tabState createState() => _T2_day_tabState();
}

class _T2_day_tabState extends State<T2_day_tab> {
  @override
  
  ///
  /// Data for grafik line 
  ///
  var _data = [
    0.6,
    1.1,
    0.4,
    0.9,
    1.2,
    0.0,
    2.3,
    0.0,
    -0.2,
    -0.2,
    -0.1,
    0.8,
    0.2
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313237),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 00.0,
            ),

            ///
            /// Grafik
            ///
            Container(
              height: 230.0,
              child: new Sparkline(
                data: _data,
                lineWidth: 0.3,
                fillMode: FillMode.below,
                lineColor: Colors.lightBlueAccent,
                fillGradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF31A1C9).withOpacity(0.7),
                    Colors.blue.withOpacity(0.01)
                  ],
                ),
              ),
            ),

            ///
            /// Value grafik
            ///
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "500",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                  Text(
                    "400",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                  Text(
                    "300",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                  Text(
                    "200",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                  Text(
                    "100",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                  Text(
                    "0",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 11.5),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            ///
            /// Card under grafic line
            ///
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 370.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFF363940),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          gradient: LinearGradient(
                            colors: [Color(0xFF31A1C9), Color(0xFF3DB6D4)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 17.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Amount of use",
                                    style: TextStyle(
                                        fontFamily: "Sans",
                                        color: Colors.white70),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "\$ 72.00",
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19.5,
                                          letterSpacing: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 35.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Colors.white),
                              child: Icon(Icons.account_balance_wallet,
                                  color: Color(0xFF3DB6D4)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    width: 3.0,
                                    color: Colors.white12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "\$9.50",
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.5,
                                          letterSpacing: 1.5,
                                          color: Colors.white70),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "May 15 2018",
                                style: TextStyle(
                                    fontFamily: "Sans", color: Colors.white70),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    width: 3.0,
                                    color: Colors.white12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "\$3.10",
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.5,
                                          letterSpacing: 1.5,
                                          color: Colors.white70),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "May 13 2018",
                                style: TextStyle(
                                    fontFamily: "Sans", color: Colors.white70),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    width: 3.0,
                                    color: Colors.yellow,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "\$3.60",
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.5,
                                          letterSpacing: 1.5,
                                          color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "May 11 2018",
                                style: TextStyle(
                                    fontFamily: "Sans", color: Colors.white70),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    width: 3.0,
                                    color: Colors.white12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "\$3.50",
                                      style: TextStyle(
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.5,
                                          letterSpacing: 1.5,
                                          color: Colors.white70),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "May 9 2018",
                                style: TextStyle(
                                    fontFamily: "Sans", color: Colors.white70),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
