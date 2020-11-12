import 'package:flutter/material.dart';

class T4_home extends StatefulWidget {
  T4_home({Key key}) : super(key: key);

  _T4_homeState createState() => _T4_homeState();
}

class _T4_homeState extends State<T4_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[

                ///
                /// Create wave appbar
                ///
                ClipPath(
                  child: Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFFA665D1), Color(0xFFFFBBCF)])),
                  ),
                  clipper: BottomWaveClipper(),
                ),


                ///
                /// Get triangle widget
                ///
                _triangle(
                  20.0,
                  10.0,
                ),
                _triangle(
                  110.0,
                  80.0,
                ),
                _triangle(
                  60.0,
                  190.0,
                ),
                _triangle(
                  40.0,
                  300.0,
                ),
                _triangle(
                  130.0,
                  330.0,
                ),

                ///
                /// Create Box below profile
                ///
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 170.0, bottom: 30.0),
                  child: Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 10.0,
                              spreadRadius: 4.0)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Send",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.mobile_screen_share,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Top Up",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.attach_money,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Pay",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.vertical_align_bottom,
                                  color: Color(0xFFB870D0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Request",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///
                /// Create profile
                ///
                Padding(
                    padding: EdgeInsets.only(top: 72.0, left: 22.0),
                    child: profile()),
              ],
            ),

            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Transactions",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w800,
                            fontSize: 15.5),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),

                ///
                /// List Transaction dummy
                ///
                _transaction(
                    Icons.gamepad, "Buying PS 5", "Monthly Payment", "-\$510"),
                _transaction(Icons.satellite, "Photo Course", "Monthly Payment",
                    "-\$50"),
                _transaction(Icons.airport_shuttle, "Car Gas Bill",
                    "Monthly Payment", "-\$210"),
                _transaction(
                    Icons.code, "Buying Template", "Monthly Payment", "-\$39"),
                _transaction(Icons.golf_course, "Golf Course",
                    "Monthly Payment", "-\$90"),
                _transaction(
                    Icons.phone, "Buying Quota", "Monthly Payment", "-\$50"),
              ],
            ),
          ],
        ),
      ),
    );
  }


  ///
  /// Create triangle 
  ///
  Widget _transaction(IconData icon, String title, String time, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Color(0xFFA665D1)),
                    child: Center(
                      child: Icon(icon),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5),
                      ),
                      Text(
                        time,
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 15.5,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.black12.withOpacity(0.1),
          )
        ],
      ),
    );
  }

  ///
  /// Triangle for appbar wave
  ///
  Widget _triangle(double top, left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: ClipPath(
        child: Container(
          height: 40.0,
          width: 40.0,
          color: Colors.white12.withOpacity(0.09),
        ),
        clipper: TriangleClipper(),
      ),
    );
  }

  ///
  /// Create profile widget
  ///
  Widget profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 53.0,
          width: 53.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(color: Colors.white, width: 2.0),
              image: DecorationImage(
                  image: AssetImage("assets/avatars/avatar-1.jpg"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 15.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Kathleen Walker",
              style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                  color: Colors.white),
            ),
            Text(
              "Member Since 18 2016",
              style: TextStyle(
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w300,
                  color: Colors.white54),
            )
          ],
        )
      ],
    );
  }
}


///
/// Create wave appbar
///
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



///
/// Create triangle clipper
///
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
