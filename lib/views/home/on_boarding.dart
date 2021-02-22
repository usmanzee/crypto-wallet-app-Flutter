import 'package:flutter/material.dart';
import 'package:crypto_template/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:crypto_template/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:crypto_template/component/style.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Theme.of(context).primaryColor,
      skipText: Text(
        "SKIP",
        style: txtStyle.descriptionStyle.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "DONE",
        style: txtStyle.descriptionStyle.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () {
        Get.offNamed('/home', arguments: {'selectedNavIndex': 0});
      },
    );
  }
}

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      title: Text(
        'B4U Wallet And Exchange',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 350.0,
        child: Text(
          'Buy, sell, trade, exchange or store digital currencies.',
          // 'Crypto application template \nbuy this code template in codecanyon',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/b1.png',
        height: 485.0,
        width: 485.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      title: Text(
        '24/7 Support',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Extensive online help desk, 24/7 global human support.',
          // 'Crypto application template \nbuy this code template in codecanyon',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/b2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      title: Text(
        'Fast Exchange',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Send or receive blockchain assets with single touch, Address or QR codes.',
          // 'Crypto application template \nbuy this code template in codecanyon',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/b3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
];
