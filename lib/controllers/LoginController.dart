import 'package:crypto_template/controllers/HomeController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_template/repository/auth_repository.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';

class LoginController extends GetxController {
  SnackbarController snackbarController;
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  TextEditingController twoFATextController;
  TextEditingController referralCodeController;
  var user = new User().obs;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    twoFATextController = TextEditingController();
    referralCodeController = TextEditingController();
    super.onInit();
  }

  void authenticate(int loginScreenType) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    AuthRepository _authRepository = new AuthRepository();

    try {
      var requestObject = {
        'email': emailTextController.text,
        'password': passwordTextController.text
      };
      if (twoFATextController.text != null &&
          twoFATextController.text != '' &&
          loginScreenType == 2) {
        requestObject['otp_code'] = twoFATextController.text;
      }
      var userData = await _authRepository.authenticate(requestObject);
      user.value = userData;
      Get.back();
      if (user.value.state == 'pending') {
        Get.toNamed('/email-verification');
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        final HomeController homeController = Get.find();
        homeController.isLoggedIn = true;
        homeController.user.value = userData;
        // Get.offAllNamed('/wallets');
        Get.back();
      }
    } catch (error) {
      Get.back();
      var errorResponseObj = error.errorResponse();
      if (errorResponseObj['statusCode'] == 401 &&
          errorResponseObj['originalMessage'] ==
              'identity.session.missing_otp') {
        Get.toNamed('/2fa');
      } else {
        snackbarController = new SnackbarController(
            title: 'Error', message: errorResponseObj['message']);
        snackbarController.showSnackbar();
      }
    }
  }

  @override
  void onClose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordTextController?.dispose();
    twoFATextController?.dispose();
    referralCodeController?.dispose();
    super.onClose();
  }
}
