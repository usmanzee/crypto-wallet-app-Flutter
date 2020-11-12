import 'package:flutter/material.dart';

class T1_wallet_detail extends StatefulWidget {
  @override
  _T1_wallet_detailState createState() => _T1_wallet_detailState();
}

class _T1_wallet_detailState extends State<T1_wallet_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      ///
      /// Appbar
      ///
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF141C35),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xFF141C35),

      ///
      /// Body
      ///
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 10.0),

                  ///
                  /// Header image with title 
                  ///
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset("assets/image/icon/icon_image.png"),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "ETHEREUM",
                              style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.5,
                                  fontSize: 17.0),
                            ),
                            Text(
                              "42kj213hjkdas23141jkb",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.5,
                                  fontSize: 13.0,
                                  color: Colors.white24),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text("0.83 ETH",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
            
            ///
            /// text editing
            ///
            _line(),
            _textEditing("To (Wallet Address)"),
            _textEditing("Amount"),
            _textEditing("Fee"),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              child: Container(
                height: 157.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF202840),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Theme(
                  data: ThemeData(hintColor: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                    child: TextField(
                      maxLines: 6,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Note",
                          labelStyle:
                              TextStyle(color: Colors.white24, fontSize: 15.0)),
                    ),
                  ),
                ),
              ),
            ),

            ///
            /// Button in bottom
            ///
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF15EDED),
                          Color(0xFF029CF5),
                        ])),
                child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 18.5, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.white10,
      ),
    );
  }

  /// 
  ///  TextEditing widget
  /// 
  Widget _textEditing(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 57.0,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(color: Colors.white24)),
        child: Theme(
          data: ThemeData(hintColor: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 0.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: title,
                  labelStyle: TextStyle(color: Colors.white24, fontSize: 15.0)),
            ),
          ),
        ),
      ),
    );
  }
}
