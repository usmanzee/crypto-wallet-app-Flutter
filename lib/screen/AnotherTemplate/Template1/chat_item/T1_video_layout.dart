import 'package:crypto_template/screen/AnotherTemplate/Template1/chat_item/T1_chating_layout.dart';
import 'package:flutter/material.dart';

class T1_video_layout extends StatefulWidget {
  @override
  _T1_video_layoutState createState() => _T1_video_layoutState();
}

class _T1_video_layoutState extends State<T1_video_layout> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: _height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/avatars/avatar-3.jpg"),
                  fit: BoxFit.cover),
            ),
          ),

          Container(
            height: 110.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  const Color(0x00000000),
                  const Color(0xF0000000),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          image: DecorationImage(
                              image: AssetImage("assets/avatars/avatar-1.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Alexandre Christie",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Popins",
                              fontSize: 16.0)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.fullscreen_exit,
                    color: Colors.white,
                    size: 29.0,
                  ),
                )
              ],
            ),
          ),

          /// For image man in bottom
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 120.0, right: 10.0),
              child: Container(
                height: 180.0,
                width: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        image: AssetImage("assets/avatars/avatar-1.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
          ),

          /// Gradient black in bottom screen
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 210.0,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [
                    const Color(0xF0000000).withOpacity(0.4),
                    const Color(0x00000000),
                  ],
                ),
              ),
            ),
          ),

          /// Icon bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// Icon menu left
                  Container(
                    height: 65.0,
                    width: 65.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        border: Border.all(color: Colors.white, width: 1.5)),
                    child: Center(
                      child: Icon(Icons.menu),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),

                  /// Icon call ended center
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new chatItem()));
                    },
                    child: Container(
                      height: 65.0,
                      width: 65.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18.0)),
                          color: Colors.red),
                      child: Center(
                        child: Icon(Icons.call_end),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.0,
                  ),

                  /// Icon video cam right
                  Container(
                    height: 65.0,
                    width: 65.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        border: Border.all(color: Colors.white, width: 1.5)),
                    child: Center(
                      child: Icon(Icons.videocam_off),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
