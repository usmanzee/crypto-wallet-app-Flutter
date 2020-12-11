import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/repository/market_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final _isLoggedIn = false.obs;
  final _selectedNavIndex = 0.obs;
  var marketList = List<Market>().obs;
  SnackbarController snackbarController;

  @override
  void onInit() {
    isUserLoggedIn();
    super.onInit();
  }

  get selectedNavIndex => this._selectedNavIndex.value;
  set selectedNavIndex(index) => this._selectedNavIndex.value = index;

  get isLoggedIn => this._isLoggedIn.value;
  set isLoggedIn(value) => this._isLoggedIn.value = value;

  void isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('loggedIn' ?? false);
    isLoggedIn = isLoggedIn != null ? isLoggedIn : false;
    print('user checked:$isLoggedIn');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
