import 'dart:convert';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_template/repository/auth_repository.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';

class LoginController extends GetxController {
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  TextEditingController twoFATextController;
  TextEditingController referralCodeController;
  HomeController homeController;
  var user = new User().obs;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    twoFATextController = TextEditingController();
    referralCodeController = TextEditingController();
    homeController = Get.find();
    super.onInit();
  }

  void authenticate(int loginScreenType) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    AuthRepository _authRepository = new AuthRepository();

    try {
      var requestObject = {
        'email': emailTextController.text,
        'password': passwordTextController.text,
        'mac': homeController.deviceMacAddress.value
      };
      if (twoFATextController.text != null &&
          twoFATextController.text != '' &&
          loginScreenType == 2) {
        requestObject['otp_code'] = twoFATextController.text;
      }
      var userData = await _authRepository.authenticate(requestObject);
      print(userData);
      Get.back();
      if (userData.state == 'pending') {
        Get.toNamed('/email-verification',
            arguments: {'email': emailTextController.text});
      } else {
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        var userToken = userData.token.split('\n')[0];
        print(userToken);
        String decoded = stringToBase64.decode(userToken);
        // String decoded = '89c36ca76662b371:6157bd6085f83466f4a5f7386d0f';
        var decodedStrArr = decoded.split(':');
        print(decodedStrArr);
        homeController.authApiKey.value = decodedStrArr[0];
        homeController.authSecret.value = decodedStrArr[1];
        user.value = userData;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        await prefs.setString('authApiKey', decodedStrArr[0]);
        await prefs.setString('authSecret', decodedStrArr[1]);
        homeController.isLoggedIn = true;
        homeController.user.value = userData;
        // Get.offAllNamed('/wallets');
        if (loginScreenType == 1) {
          Get.back();
        } else {
          Get.back();
          Get.back();
        }
      }
    } catch (error) {
      print(error);
      Get.back();
      try {
        var errorResponseObj = error.errorResponse();
        print(errorResponseObj);
        if (errorResponseObj['statusCode'] == 401 &&
            errorResponseObj['originalMessage'] ==
                'identity.session.missing_otp') {
          Get.toNamed('/2fa');
        } else {
          snackbarController = new SnackbarController(
              title: 'Error', message: errorResponseObj['message']);
          snackbarController.showSnackbar();
        }
      } catch (error) {
        print(error);
        snackbarController = new SnackbarController(
            title: 'Error', message: 'Incorrect data formate from server side');
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
