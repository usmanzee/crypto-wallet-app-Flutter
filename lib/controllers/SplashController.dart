import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  SnackbarController snackbarController;

  @override
  void onInit() {
    startTime();

    super.onInit();
  }

  startTime() async {
    return new Timer(Duration(milliseconds: 4500), isNewUser);
  }

  void isNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seenOnBoarding = (prefs.getBool('seen_on_boarding') ?? false);
    _seenOnBoarding = _seenOnBoarding != null ? _seenOnBoarding : false;
    if (_seenOnBoarding) {
      Get.offNamed('/home');
    } else {
      await prefs.setBool('seen_on_boarding', true);
      Get.offNamed('/on_bording');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
