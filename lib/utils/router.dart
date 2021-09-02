import 'package:b4u_wallet/bindings/email_verification_binding.dart';
import 'package:b4u_wallet/bindings/home_binding.dart';
import 'package:b4u_wallet/bindings/market_detail_binding.dart';
import 'package:b4u_wallet/bindings/notification_screen_binding.dart';
import 'package:b4u_wallet/bindings/otp_binding.dart';
import 'package:b4u_wallet/bindings/p2p_binding.dart';
import 'package:b4u_wallet/bindings/savings_binding.dart';
import 'package:b4u_wallet/bindings/security_binding.dart';
import 'package:b4u_wallet/bindings/swap_history_binding.dart';
import 'package:b4u_wallet/bindings/transfer_binding.dart';
import 'package:b4u_wallet/bindings/verification_binding.dart';
import 'package:b4u_wallet/bindings/wallet_search_binding.dart';
import 'package:b4u_wallet/views/DetailCryptoValue/market_detail.dart';
import 'package:b4u_wallet/views/auth/2fa.dart';
import 'package:b4u_wallet/views/auth/email_verification.dart';
import 'package:b4u_wallet/views/auth/login.dart';
import 'package:b4u_wallet/views/auth/signup.dart';
import 'package:b4u_wallet/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:b4u_wallet/views/history/history.dart';
import 'package:b4u_wallet/views/history/spot_history/spot_hisotry_page.dart';
import 'package:b4u_wallet/views/home/on_boarding.dart';
import 'package:b4u_wallet/views/home/splash.dart';
import 'package:b4u_wallet/views/notification/%20notification_list.dart';
import 'package:b4u_wallet/views/p2p/appeal_page/p2p_buy_sell_appeal_page.dart';
import 'package:b4u_wallet/views/p2p/appeal_page/p2p_buy_sell_appeal_pending_page.dart';
import 'package:b4u_wallet/views/p2p/appeal_page/p2p_buy_sell_appeal_progress_page.dart';
import 'package:b4u_wallet/views/p2p/appeal_page/p2p_buy_sell_initia_appeal_page.dart';
import 'package:b4u_wallet/views/p2p/components/p2p_ads_page_level_check_page.dart';
import 'package:b4u_wallet/views/p2p/components/search_currency_p2p_dialog.dart';
import 'package:b4u_wallet/views/p2p/components/select_currency_p2p_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_ad_sharing_code_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/p2p_ad_posted_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/p2p_ads_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/post_add_pages/p2p_ad_post_initial_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page_history_page/p2p_ads_page_history_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_initial_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_order_history_page/p2p_orders_history_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_offer_process/P2p_buy_sell_selected_offer_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_offer_process/p2p_buy_order_complete_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_offer_process/p2p_buy_payment_method_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_offer_process/p2p_buy_payment_pending_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_offer_process/p2p_buy_payment_release_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_offer_process/seller_offer_side_pages/p2p_seller_offer_complete_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_sell_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_chat_page/p2p_chat_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_history_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_feedback_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_help_center_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_notifications_setting_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_payment/p2p_payment_method_add_bank_details_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_payment/p2p_payment_method_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_payment/p2p_select_all_payment_method_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_payment/p2p_select_payment_method_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_user_profile.dart';
import 'package:b4u_wallet/views/savings/savings.dart';
import 'package:b4u_wallet/views/security/enable_otp.dart';
import 'package:b4u_wallet/views/security/security.dart';
import 'package:b4u_wallet/views/setting/payment_methods_page.dart';
import 'package:b4u_wallet/views/setting/setting.dart';
import 'package:b4u_wallet/views/swap/swap.dart';
import 'package:b4u_wallet/views/swap/swap_histroy.dart';
import 'package:b4u_wallet/views/transfer/transfer_page.dart';
import 'package:b4u_wallet/views/verification/verification.dart';
import 'package:b4u_wallet/views/verification/verification_level.dart';
import 'package:b4u_wallet/views/wallet/deposit/crypto.dart';
import 'package:b4u_wallet/views/wallet/wallet_detail.dart';
import 'package:b4u_wallet/views/wallet/wallet_search.dart';
import 'package:b4u_wallet/views/wallet/withdraw/crypto.dart';
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
      name: '/wallet-detail',
      page: () => WalletDetail(),
    ),
    GetPage(
      name: '/deposit-crypto',
      page: () => DepositCrypto(),
    ),
    GetPage(
      name: '/withdrawl-crypto',
      page: () => WithdrawCrypto(),
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
      // binding: SwapBinding(),
    ),
    GetPage(
      name: '/swap-history',
      page: () => SwapHistory(),
      binding: SwapHistoryBinding(),
    ),
    GetPage(
      name: '/verification-level',
      page: () => VerificationLevel(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: '/profile-verification',
      page: () => Verification(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: '/history',
      page: () => History(),
    ),
    GetPage(
      name: '/savings',
      page: () => Savings(),
      binding: SavingsBinding(),
    ),
    GetPage(
      name: '/transfer_page',
      page: () => TransferPage(),
      binding: TransferBinding(),
    ),
    GetPage(
      name: '/p2p_page',
      page: () => P2pBuySellPage(),
    ),
    GetPage(
      name: '/p2p_user_profile',
      page: () => P2pUserProfile(),
    ),
    GetPage(
      name: '/p2p_feedback_page',
      page: () => P2pFeedbackPage(),
    ),
    GetPage(
      name: '/p2p_initial_page',
      page: () => P2pInitialPage(),
    ),
    GetPage(
      name: '/p2p_payment_method',
      page: () => P2pPaymentMethodPage(),
    ),
    GetPage(
      name: '/p2p_notification_setting_page',
      page: () => P2pNotificationsSettingPage(),
    ),
    GetPage(
      name: '/p2p_help_center_page',
      page: () => P2pHelpCanterPage(),
    ),
    GetPage(
      name: '/spot_history_page',
      page: () => SpotHistoryPage(),
    ),
    GetPage(
      name: '/select_currency_p2p_page',
      page: () => SelectCurrencyP2pScreen(),
    ),
    GetPage(
      name: '/search_currency_p2p_dialog',
      page: () => SearchCurrencyP2pDialog(),
    ),
    GetPage(
      name: '/p2p_history_page',
      page: () => P2pHistoryPage(),
    ),
    GetPage(
      name: '/p2p_buy_sell_selected_offer_page',
      page: () => P2pBuySellSelectedOfferPage(),
    ),
    GetPage(
      name: '/p2p_buy_payment_pending_page',
      page: () => P2pBuyPaymentPendingPage(),
    ),
    GetPage(
      name: '/p2p_buy_payment_method_page',
      page: () => P2pBuyPaymentMethodPage(),
    ),
    GetPage(
      name: '/p2p_buy_payment_release_page',
      page: () => P2pBuyPaymentReleasePage(),
    ),
    GetPage(
      name: '/p2p_buy_order_complete_page',
      page: () => P2pBuyOrderCompletePage(),
    ),
    GetPage(
      name: '/p2p_buy_sell_initial_appeal_page',
      page: () => P2pBuySellInitialAppealPage(),
    ),
    GetPage(
      name: '/p2p_chat_page',
      page: () => P2pChatPage(),
    ),
    GetPage(
      name: '/p2p_bottom_nav_page',
      page: () => P2pBottomNavPage(),
      binding: P2pBinding(),
    ),
    GetPage(
      name: '/p2p_orders_history_page',
      page: () => P2pOrdersHistoryPage(),
    ),
    GetPage(
      name: '/p2p_ads_page',
      page: () => P2pAdsPage(),
    ),
    GetPage(
      name: '/p2p_ads_page_history_page',
      page: () => P2pAdsPageHistoryPage(),
    ),
    GetPage(
      name: '/p2p_ads_page_level_check_page',
      page: () => P2pAdsPageLevelCheckPage(),
    ),
    GetPage(
      name: '/p2p_buy_sell_appeal_page',
      page: () => P2pBuySellAppealPage(),
    ),
    GetPage(
      name: '/p2p_buy_sell_appeal_pending_page',
      page: () => P2pBuySellAppealPendingPage(),
    ),
    GetPage(
      name: '/p2p_buy_sell_appeal_progress_page',
      page: () => P2pBuySellAppealProgressPage(),
    ),
    GetPage(
      name: '/payment_methods_page',
      page: () => PaymentMethodsPage(),
    ),
    GetPage(
      name: '/p2p_ad_sharing_code_page',
      page: () => P2pAdSharingCodePage(),
    ),
    GetPage(
      name: '/p2p_select_payment_method_page',
      page: () => P2pSelectPaymentMethodPage(),
    ),
    GetPage(
      name: '/p2p_select_all_payment_method_page',
      page: () => P2pSelectAllPaymentMethodPage(),
    ),
    GetPage(
      name: '/p2p_payment_method_add_bank_details_page',
      page: () => P2pPaymentMethodAddBankDetailsPage(),
    ),
    GetPage(
      name: '/p2p_seller_offer_complete_page',
      page: () => P2pSellerOfferCompletePage(),
    ),
    GetPage(
      name: '/p2p_ad_posted_page',
      page: () => P2pAdPostedPage(),
    ),

    GetPage(
      name: '/p2p_ad_post_initial_page',
      page: () => P2pAdPostInitialPage(),
    ),
  ];
}
