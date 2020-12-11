import 'package:crypto_template/views/auth/email_verification.dart';
import 'package:crypto_template/views/auth/login.dart';
import 'package:crypto_template/views/auth/2fa.dart';
import 'package:crypto_template/views/auth/signup.dart';
import 'package:crypto_template/views/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:get/get.dart';

class Router {
  static final route = [
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
  ];
}
