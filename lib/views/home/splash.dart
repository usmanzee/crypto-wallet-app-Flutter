import 'dart:async';
import 'package:crypto_template/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// Component UI
// class SplashScreen extends StatefulWidget {
//   final ThemeBloc themeBloc;
//   SplashScreen({this.themeBloc});
//   @override
//   _SplashScreenState createState() => _SplashScreenState(themeBloc);
// }

/// Component UI
class SplashScreen extends StatelessWidget {
  final ThemeBloc themeBloc;
  SplashScreen({this.themeBloc});

  final splashController = Get.put(SplashController());

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        /// Set Background image in splash screen layout (Click to open code)
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/image/splash_screen.png'),
        //         fit: BoxFit.cover)),
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
                      Image.asset("assets/image/b4u_wallet_logo.png",
                          height: 50.0),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0, top: 0.0),
                      //   child: Text(
                      //     "B4U",
                      //     style: TextStyle(
                      //         fontFamily: "Sans",
                      //         // color: Colors.white,
                      //         fontSize: 32.0,
                      //         fontWeight: FontWeight.w300,
                      //         letterSpacing: 3.9),
                      //   ),
                      // ),
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
