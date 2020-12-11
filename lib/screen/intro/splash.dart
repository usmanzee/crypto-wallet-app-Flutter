import 'dart:async';
import 'package:crypto_template/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:crypto_template/screen/intro/login.dart';
import 'package:crypto_template/screen/intro/on_Boarding.dart';
import 'package:crypto_template/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Component UI
class SplashScreen extends StatefulWidget {
  final ThemeBloc themeBloc;
  SplashScreen({this.themeBloc});
  @override
  _SplashScreenState createState() => _SplashScreenState(themeBloc);
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  ThemeBloc themeBloc;
  _SplashScreenState(this.themeBloc);

  /// Setting duration in splash screen
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), checkFirstSeen);
  }

  /// To navigate layout change
  void navigatorPage() {
    Navigator.of(context).pushReplacementNamed("onBoarding");
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new BottomNavBar()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoarding()));
    }
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/splash_screen.png'),
                fit: BoxFit.cover)),
        child: Container(
          /// Set gradient black in image splash screen (Click to open code)
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromRGBO(0, 0, 0, 0.1),
                Color.fromRGBO(0, 0, 0, 0.1)
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/image/logo.png", height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0, top: 7.0),
                        child: Text(
                          "Crypto",
                          style: TextStyle(
                              fontFamily: "Sans",
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 3.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
