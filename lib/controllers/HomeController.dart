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

  @override
  void onInit() async {
    selectedNavIndex =
        Get.arguments != null ? Get.arguments['selectedNavIndex'] : 0;
    bool isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      fetchUser();
    }
    connectivity = new Connectivity();
    subscription = connectivity.onConnectivityChanged.listen(_connectionChange);
    super.onInit();
  }

  void _connectionChange(ConnectivityResult result) {
    print('change');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedIn');
    isLoggedIn.value = false;
    snackbarController =
        new SnackbarController(title: 'Error', message: 'Loggedout.');
    snackbarController.showSnackbar();
    // Get.offNamed('/home', arguments: {'selectedNavIndex': 0});
  }

  void changePage() {
    print(Get.arguments['selectedNavIndex']);
    selectedNavIndex =
        Get.arguments != null ? Get.arguments['selectedNavIndex'] : 0;
  }

  Future<Null> refreshHomePage() async {
    // await Future.delayed(Duration(seconds: 2));
    MarketController marketController = Get.find<MarketController>();
    marketController.fetchMarkets();
    if (isLoggedIn.value) {
      fetchUser();
    }
  }

  Future<Null> refreshMarketsPage() async {
    // await Future.delayed(Duration(seconds: 2));
    MarketController marketController = Get.find<MarketController>();
    marketController.fetchMarkets();
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
    // await Future.delayed(Duration(seconds: 2));
    WalletController walletController = Get.find<WalletController>();
    walletController.fetchWallets();
  }

  void fetchUser() async {
    try {
      fetchingUser(true);
      UserRepository _userRepository = new UserRepository();
      var userData = await _userRepository.fetchUser();
      user.value = userData;
      fetchingUser(true);
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

  @override
  void onClose() {
    super.onClose();
    subscription.cancel();
  }
}
