import 'dart:async';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/controllers/open_orders_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/models/MemberLevel.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/repository/public_repository.dart';
import 'package:crypto_template/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
// import 'package:get_mac/get_mac.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeController extends GetxController {
  // final int activeNavIndex = Get.arguments['selectedNavIndex'];
  final _hasConnection = true.obs;
  final _previousConnection = false.obs;
  final isLoggedIn = false.obs;
  var _selectedNavIndex = 0.obs;
  var marketList = List<Market>().obs;
  var fetchingUser = false.obs;
  var user = new User().obs;
  var deviceMacAddress = 'unknown'.obs;
  var authApiKey = 'unknown'.obs;
  var authSecret = 'unknown'.obs;
  var fetchingMemberLevel = false.obs;
  var publicMemberLevel = MemberLevel().obs;

  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  bool isChanged = false;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  get selectedNavIndex => this._selectedNavIndex.value;
  set selectedNavIndex(index) => this._selectedNavIndex.value = index;

  // get isLoggedIn => this.isLoggedIn.value;
  // set isLoggedIn(value) => this.isLoggedIn.value = value;

  get hasConnection => this._hasConnection.value;
  set hasConnection(value) => this._hasConnection.value = value;

  get previousConnection => this._previousConnection.value;
  set previousConnection(value) => this._previousConnection.value = value;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void onInit() async {
    selectedNavIndex =
        Get.arguments != null ? Get.arguments['selectedNavIndex'] : 0;
    await isUserLoggedIn();
    if (isLoggedIn.value) {
      fetchUser();
    }
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(_connectionChange);
    firebaseeMessagingConfig();
    ever(isLoggedIn, setValuesAfterLogin);
    super.onInit();
  }

  setValuesAfterLogin(bool isUserLoggedIn) {
    if (isUserLoggedIn) {
      print('get token');
      getFirebaseToken();
    }
  }

  void firebaseeMessagingConfig() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // isLoggedIn ?? Get.toNamed('/notifications');
        Get.toNamed('/notifications');
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // isLoggedIn ?? Get.toNamed('/notifications');
        Get.toNamed('/notifications');
        // _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    if (isLoggedIn.value) {
      getFirebaseToken();
    }
  }

  void getFirebaseToken() {
    _firebaseMessaging.getToken().then((String token) {
      print('token: ' + token);
      if (token != null) {
        saveFirebaseDeviceToken(token);
      }
    });
  }

  void _connectionChange(ConnectivityResult result) {
    previousConnection = hasConnection;
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      hasConnection = true;
    } else {
      hasConnection = false;
    }
    if (!previousConnection) {
      refreshHomePage();
    }
  }

  // void fetchMacAddress() async {
  //   try {
  //     deviceMacAddress.value = await GetMac.macAddress;
  //   } on PlatformException {
  //     deviceMacAddress.value = 'Failed to get Device MAC Address.';
  //   }
  // }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('loggedIn' ?? false);
    authApiKey.value = prefs.getString('authApiKey');
    authSecret.value = prefs.getString('authSecret');
    isLoggedIn.value = isLoggedIn.value != null ? isLoggedIn.value : false;
    return isLoggedIn.value;
  }

  void logoutUser() async {
    user.value = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedIn');
    isLoggedIn.value = false;
    snackbarController = new SnackbarController(
        title: 'Error', message: 'Your login session has expired.');
    snackbarController.showSnackbar();
  }

  void changePage() {
    selectedNavIndex =
        Get.arguments != null ? Get.arguments['selectedNavIndex'] : 0;
  }

  Future<Null> refreshHomePage() async {
    // await Future.delayed(Duration(seconds: 2));
    bool marketControllerInstance = Get.isRegistered<MarketController>();
    if (marketControllerInstance) {
      Get.delete<MarketController>(force: true);
      Get.put(MarketController());
    }
    if (isLoggedIn.value) {
      fetchUser();
    }
  }

  Future<Null> refreshMarketsPage() async {
    bool marketControllerInstance = Get.isRegistered<MarketController>();
    if (marketControllerInstance) {
      Get.delete<MarketController>(force: true);
      Get.put(MarketController());
    }
  }

  Future<Null> refreshTradingPage() async {
    MarketController marketController = Get.find<MarketController>();
    bool tradingCOntrollerInstance = Get.isRegistered<TradingController>();
    if (tradingCOntrollerInstance) {
      Get.delete<TradingController>(force: true);
      Get.put(TradingController());
    }
    bool openOrdersInstance = Get.isRegistered<OpenOrdersController>();
    if (openOrdersInstance) {
      Get.delete<OpenOrdersController>(force: true);
      Get.put(OpenOrdersController(
          formatedMarket: marketController.selectedMarketTrading.value));
    }
  }

  Future<Null> refreshWalletsPage() async {
    bool walletControllerInstance = Get.isRegistered<WalletController>();
    if (walletControllerInstance) {
      Get.delete<WalletController>(force: true);
      Get.put(WalletController());
    }
  }

  void fetchUser() async {
    try {
      fetchingUser(true);
      UserRepository _userRepository = new UserRepository();
      var userData = await _userRepository.fetchUser();
      user.value = userData;
      fetchingUser(false);
    } catch (error) {
      fetchingUser(false);
      errorController.handleError(error);
    }
  }

  void fetchMemberLevels() async {
    try {
      fetchingMemberLevel(true);
      PublicRepository _publicRepository = new PublicRepository();
      var response = await _publicRepository.fetchMemberLevels();
      publicMemberLevel.value = response;
      fetchingMemberLevel(false);
    } catch (error) {
      fetchingMemberLevel(false);
      errorController.handleError(error);
    }
  }

  void saveFirebaseDeviceToken(String token) async {
    try {
      var obj = {'notification': token};
      UserRepository _userRepository = new UserRepository();
      await _userRepository.saveFirebaseDeviceToken(obj);
      print('Token saved!');
    } catch (error) {
      print('error while saving token!');
      print(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
    subscription.cancel();
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
