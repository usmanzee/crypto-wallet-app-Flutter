import 'package:b4u_wallet/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/views/setting/themes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final ThemeBloc themeBloc;
  SplashScreen({this.themeBloc});

  final splashController = Get.put(SplashController());

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
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
