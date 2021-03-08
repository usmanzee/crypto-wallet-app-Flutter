import 'package:crypto_template/bindings/email_verification_binding.dart';
import 'package:crypto_template/bindings/home_binding.dart';
import 'package:crypto_template/bindings/market_detail_binding.dart';
import 'package:crypto_template/bindings/notification_screen_binding.dart';
import 'package:crypto_template/bindings/otp_binding.dart';
import 'package:crypto_template/bindings/security_binding.dart';
import 'package:crypto_template/bindings/swap_binding.dart';
import 'package:crypto_template/bindings/swap_history_binding.dart';
import 'package:crypto_template/bindings/verification_binding.dart';
import 'package:crypto_template/bindings/wallet_search_binding.dart';
import 'package:crypto_template/views/DetailCryptoValue/market_detail.dart';
import 'package:crypto_template/views/home/splash.dart';
import 'package:crypto_template/views/home/on_boarding.dart';
import 'package:crypto_template/views/auth/email_verification.dart';
import 'package:crypto_template/views/auth/login.dart';
import 'package:crypto_template/views/auth/2fa.dart';
import 'package:crypto_template/views/auth/signup.dart';
import 'package:crypto_template/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crypto_template/views/notification/%20notification_list.dart';
import 'package:crypto_template/views/security/enable_otp.dart';
import 'package:crypto_template/views/security/security.dart';
import 'package:crypto_template/views/setting/setting.dart';
import 'package:crypto_template/views/swap/swap.dart';
import 'package:crypto_template/views/swap/swap_histroy.dart';
import 'package:crypto_template/views/verification/verification.dart';
import 'package:crypto_template/views/verification/verification_level.dart';
import 'package:crypto_template/views/wallet/wallet_search.dart';
import 'package:get/get.dart';

class Router {
  static final route = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      // binding: SplashScreenBinding(),
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
    GetPage(
      name: '/settings',
      page: () => Setting(),
    ),
    GetPage(
        name: '/security', page: () => Security(), binding: SecurityBinding()),
    GetPage(
        name: '/enable-otp', page: () => EnableOTP(), binding: OTPBinding()),
    GetPage(
        name: '/notifications',
        page: () => NotificationList(),
        binding: NotificationScreenBinding()),
    GetPage(
        name: '/email-verification',
        page: () => EmailVerification(),
        binding: EmailVerificationBinding()),
    GetPage(
      name: '/home',
      page: () => BottomNavBar(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/trading',
      page: () => BottomNavBar(),
      // binding: TradingBinding(),
    ),
    GetPage(
      name: '/wallets',
      page: () => BottomNavBar(),
    ),
    GetPage(
        name: '/wallets-search',
        page: () => WalletSearch(),
        binding: WalletSearchBinding()),
    GetPage(
      name: '/market-detail',
      page: () => MarketDetail(),
      binding: MarketDetailBinding(),
    ),
    GetPage(
      name: '/swap',
      page: () => Swap(),
      binding: SwapBinding(),
    ),
    GetPage(
      name: '/swap-history',
      page: () => SwapHistory(),
      binding: SwapHistoryBinding(),
    ),
    // GetPage(
    //   name: '/verification-level',
    //   page: () => VerificationLevel(),
    //   binding: VerificationBinding(),
    // ),
    GetPage(
      name: '/profile-verification',
      page: () => Verification(),
      binding: VerificationBinding(),
    ),
  ];
}
