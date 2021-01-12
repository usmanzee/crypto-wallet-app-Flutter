import 'package:crypto_template/views/wallet/wallet_detail.dart';
import 'package:crypto_template/views/home/splash.dart';
import 'package:crypto_template/views/home/on_boarding.dart';
import 'package:crypto_template/views/auth/email_verification.dart';
import 'package:crypto_template/views/auth/login.dart';
import 'package:crypto_template/views/auth/2fa.dart';
import 'package:crypto_template/views/auth/signup.dart';
import 'package:crypto_template/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:get/get.dart';

class Router {
  static final route = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/on_boarding',
      page: () => OnBoarding(),
    ),
    GetPage(
      name: '/login',
      page: () => Login(),
    ),
    GetPage(
      name: '/2fa',
      page: () => TwoFA(),
    ),
    GetPage(
      name: '/register',
      page: () => SignUp(),
    ),
    // GetPage(
    //   name: '/profile',
    //   page: () => Settings(),
    // ),
    GetPage(
      name: '/email-verification',
      page: () => EmailVerification(),
    ),
    GetPage(
      name: '/home',
      page: () => BottomNavBar(),
    ),
    GetPage(
      name: '/wallets',
      page: () => BottomNavBar(),
    ),
    // GetPage(
    //   name: '/wallet-detail',
    //   page: () => WalletDetail(wallet),
    // ),
  ];
}
