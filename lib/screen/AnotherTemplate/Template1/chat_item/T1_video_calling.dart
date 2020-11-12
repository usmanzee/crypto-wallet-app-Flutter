import 'dart:async';

import 'package:crypto_template/screen/AnotherTemplate/Template1/chat_item/T1_chating_layout.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/chat_item/T1_video_layout.dart';
import 'package:flutter/material.dart';

class T1_video_calling extends StatefulWidget {
  @override
  _T1_video_callingState createState() => _T1_video_callingState();
}

class _T1_video_callingState extends State<T1_video_calling> {
  @override

  /// Setting duration for next screen
  startTime() async {
    return new Timer(Duration(milliseconds: 4000), NavigatorPage);
  }

  /// To navigate layout change
  void NavigatorPage() {
    Navigator.of(context).pushReplacement(
        PageRouteBuilder(pageBuilder: (_, __, ___) => new T1_video_layout()));
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: _height,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF1E2643),
              Color(0xFF0D1327),
            ])),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/avatars/avatar-1.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      "Alexandre Christie",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.0,
                          fontFamily: "Popins"),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Incoming......",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          fontFamily: "Sans",
                          letterSpacing: 1.5),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new chatItem()));
                  },
                  child: Container(
                    height: 55.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.redAccent,
                    ),
                    child: Center(
                        child: Icon(
                      Icons.phone_missed,
                      color: Colors.white,
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
