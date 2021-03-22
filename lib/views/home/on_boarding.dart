import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Get.offNamed('/home', arguments: {'selectedNavIndex': 0});
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = TextStyle(fontFamily: 'popins', fontSize: 16.0);
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontFamily: 'popins', fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "B4U Wallet & Exchange",
          body:
              "Application allows to buy, sell, trade, exchange or store digital currencies.",
          image: _buildImage('ilustration/b1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "24/7 Human Support",
          body: "Extensive online help desk, 24/7 global human support.",
          image: _buildImage('ilustration/b2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fast Exchange",
          body:
              "Send or receive blockchain assets with single touch, Address or QR codes.",
          image: _buildImage('ilustration/b3'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'SKIP',
        style: TextStyle(fontFamily: 'popins', fontWeight: FontWeight.w600),
      ),
      next: const Icon(Icons.arrow_forward),
      done: const Text('DONE',
          style: TextStyle(fontFamily: 'popins', fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Theme.of(context).hintColor,
        activeSize: Size(22.0, 10.0),
        activeColor: Theme.of(context).primaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
