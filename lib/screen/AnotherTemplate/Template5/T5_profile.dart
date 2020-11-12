import 'package:crypto_template/screen/AnotherTemplate/Template2/T2_Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class T5_profile extends StatefulWidget {
  T5_profile({Key key}) : super(key: key);

  _T5_profileState createState() => _T5_profileState();
}

class _T5_profileState extends State<T5_profile> {
  bool _switch1 = false;
  bool _switch2 = false;
  int tapvalue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),

      ///
      /// Appbar
      ///
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: "Lemon",
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
              color: Colors.black87),
        ),
        elevation: 0.2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            ///
            /// This is card box for profile 
            ///
            _cardProfile(),
            SizedBox(
              height: 10.0,
            ),

            _cardAnother()
          ],
        ),
      ),
    );
  }

  var _txtStyleTitle = TextStyle(
      color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 15.0);

  var _txtStyleDeskripsi =
      TextStyle(color: Colors.black26, fontWeight: FontWeight.w400);

  Widget _cardProfile() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 180.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      gradient: LinearGradient(
                          colors: [Color(0xFF3FCE98), Color(0xFF76EE93)])),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/avatars/avatar-1.jpg"),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Jipau Developer",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Popins",
                              letterSpacing: 1.5),
                        ),
                        Text(
                          "Jipaudev@gmail.com",
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontFamily: "Sans",
                              fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "General",
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Popins"),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Personal details",
                    style: _txtStyleTitle,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "You can edit your information about your email address, phone number, or pysical address",
                    style: _txtStyleDeskripsi,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _line(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Fingerprint", style: _txtStyleTitle),
                      Switch(
                        value: _switch1,
                        onChanged: (bool e) => _something(e),
                        activeColor: Colors.lightBlueAccent,
                        inactiveTrackColor: Colors.black12,
                      ),
                    ],
                  ),
                  _line(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Change Passcode",
                    style: _txtStyleTitle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _line(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Notifications", style: _txtStyleTitle),
                      Switch(
                        value: _switch2,
                        onChanged: (bool e) => _something2(e),
                        activeColor: Colors.lightBlueAccent,
                        inactiveTrackColor: Colors.black12,
                      ),
                    ],
                  ),
                  Text(
                      "Manage if you want to receive updates about promotions features or news",
                      style: _txtStyleDeskripsi),
                  SizedBox(
                    height: 15.0,
                  ),
                  _line(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("Categories (17)", style: _txtStyleTitle),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                      "Add or remove categories to create full control over your expenses and categories",
                      style: _txtStyleDeskripsi),
                  SizedBox(
                    height: 25.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardAnother() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                  spreadRadius: 0.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text("Another",
                  style: _txtStyleTitle.copyWith(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              SizedBox(
                height: 25.0,
              ),
              _line(),
              SizedBox(
                height: 20.0,
              ),
              Text("Rate this app", style: _txtStyleTitle),
              SizedBox(
                height: 20.0,
              ),
              _line(),
              SizedBox(
                height: 20.0,
              ),
              Text("Support", style: _txtStyleTitle),
              SizedBox(
                height: 20.0,
              ),
              _line(),
              SizedBox(
                height: 20.0,
              ),
              Text("Share", style: _txtStyleTitle),
              SizedBox(
                height: 20.0,
              ),
              _line(),
              SizedBox(
                height: 20.0,
              ),
              Text("Terms and policy", style: _txtStyleTitle),
              SizedBox(
                height: 20.0,
              ),
              _line(),
              SizedBox(
                height: 20.0,
              ),
              Text("Logout", style: _txtStyleTitle),
              SizedBox(
                height: 20.0,
              ),
              _line(),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 1.5,
      width: double.infinity,
      color: Colors.black12.withOpacity(0.03),
    );
  }

  ///
  /// void for radio button finger print
  ///
  void _something(bool e) {
    setState(() {
      if (e) {
        e = true;
        _switch1 = true;
      } else {
        e = false;
        _switch1 = false;
      }
    });
  }

  ///
  /// void for radio button notifications
  ///
  void _something2(bool e) {
    setState(() {
      if (e) {
        e = true;
        _switch2 = true;
      } else {
        e = false;
        _switch2 = false;
      }
    });
  }
}
