import 'dart:async';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/models/market.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final _isLoggedIn = false.obs;
  final _selectedNavIndex = 0.obs;
  var marketList = List<Market>().obs;
  SnackbarController snackbarController;
  var user = new User().obs;

  @override
  void onInit() async {
    bool isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      fetchUser();
    }
    super.onInit();
  }

  get selectedNavIndex => this._selectedNavIndex.value;
  set selectedNavIndex(index) => this._selectedNavIndex.value = index;

  get isLoggedIn => this._isLoggedIn.value;
  set isLoggedIn(value) => this._isLoggedIn.value = value;

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('loggedIn' ?? false);
    isLoggedIn = isLoggedIn != null ? isLoggedIn : false;
    print('user checked:$isLoggedIn');
    return isLoggedIn;
  }

  void fetchUser() async {
    UserRepository _userRepository = new UserRepository();
    var userData = await _userRepository.fetchUser();
    user.value = userData;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
