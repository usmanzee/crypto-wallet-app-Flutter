import 'package:flutter/material.dart';
import 'package:crypto_template/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:crypto_template/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:crypto_template/views/auth/login.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/component/style.dart';

class OnBoarding extends StatefulWidget {
  final ThemeBloc themeBloc;
  OnBoarding({this.themeBloc});
  @override
  _OnBoardingState createState() => _OnBoardingState(themeBloc);
}

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      pageColor: colorStyle.background,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Crypto Template',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Crypto application template \nbuy this code template in codecanyon',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/boarding1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: colorStyle.background,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Crypto Template',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Crypto application template \nbuy this code template in codecanyon',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/boarding2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: colorStyle.background,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Crypto Template',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Crypto application template \nbuy this code template in codecanyon',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/boarding3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
];

class _OnBoardingState extends State<OnBoarding> {
  ThemeBloc _themeBloc;
  _OnBoardingState(this._themeBloc);
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Colors.black45,
      skipText: Text(
        "SKIP",
        style: txtStyle.descriptionStyle.copyWith(
            color: Color(0xFF45C2DA),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: txtStyle.descriptionStyle.copyWith(
            color: Color(0xFF45C2DA),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new Login(themeBloc: _themeBloc)));
      },
    );
  }
}
