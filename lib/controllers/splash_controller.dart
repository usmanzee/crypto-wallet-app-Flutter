import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get_storage/get_storage.dart';

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
    var _seenOnBoarding = GetStorage().read('seenOnBoarding');
    _seenOnBoarding = _seenOnBoarding != null ? _seenOnBoarding : false;
    if (_seenOnBoarding) {
      Get.offNamed('/home', arguments: {'selectedNavIndex': 0});
    } else {
      GetStorage().write('seenOnBoarding', true);
      Get.offNamed('/on_boarding');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
