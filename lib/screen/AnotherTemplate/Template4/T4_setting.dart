import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_aboutApps.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_callCenter.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_message.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_notification.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_payment.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/setting_layout/T4_setting_account.dart';
import 'package:flutter/material.dart';

class T4_setting extends StatefulWidget {
  T4_setting({Key key}) : super(key: key);

  _T4_settingState createState() => _T4_settingState();
}

class _T4_settingState extends State<T4_setting> {
  @override
  static var _txtCustomHead = TextStyle(
    color: Colors.black54,
    fontSize: 17.0,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  static var _txtCustomSub = TextStyle(
    color: Colors.black38,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFD),
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
                    height: 160.0,
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
                Padding(
                  padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                  child: Text(
                    "Setting",
                    style:
                        TextStyle(fontSize: 27.0, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),

            ///
            /// Create list for category
            ///
            category(
              txt: "Notification",
              padding: 35.0,
              image: "assets/icon/Template4/notification.png",
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_notification()));
              },
            ),
            _line(),
            category(
              txt: "Payments",
              padding: 35.0,
              image: "assets/icon/Template4/creditAcount.png",
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_payment()));
              },
            ),
            _line(),
            category(
              txt: "Message",
              padding: 26.0,
              image: "assets/icon/Template4/chat.png",
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_message()));
              },
            ),
            _line(),
            category(
              txt: "Setting Acount",
              padding: 30.0,
              image: "assets/icon/Template4/setting.png",
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_settingAccount()));
              },
            ),
            _line(),
            category(
              txt: "Call Center",
              padding: 30.0,
              image: "assets/icon/Template4/callcenter.png",
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_callCenter()));
              },
            ),
            _line(),
            category(
              padding: 38.0,
              txt: "About Apps",
              image: "assets/icon/Template4/aboutapp.png",
              tap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_aboutApps()));
              },
            ),
            _line(),
            Padding(padding: EdgeInsets.only(bottom: 20.0)),
          ],
        ),
      ),
    );
  }

  Widget _line() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 85.0, right: 30.0),
      child: Divider(
        color: Colors.black12,
        height: 2.0,
      ),
    );
  }


  ///
  /// Create triangle 
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

/// Custom Font
var _txt = TextStyle(
  color: Colors.black,
  fontFamily: "Sans",
);

/// Get _txt and custom value of Variable for Category Text
var _txtCategory = _txt.copyWith(
    fontSize: 14.5, color: Colors.black54, fontWeight: FontWeight.w500);

/// Component category class to set list
class category extends StatelessWidget {
  @override
  String txt, image;
  GestureTapCallback tap;
  double padding;

  category({this.txt, this.image, this.tap, this.padding});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: Image.asset(
                    image,
                    height: 25.0,
                    color: Color(0xFFA665D1),
                  ),
                ),
                Text(
                  txt,
                  style: _txtCategory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
