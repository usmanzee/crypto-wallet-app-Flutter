import 'dart:convert';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/models/user.dart';
import 'package:b4u_wallet/repository/auth_repository.dart';
import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:get_storage/get_storage.dart';

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
      Get.back();
      if (userData.state == 'pending') {
        Get.toNamed('/email-verification',
            arguments: {'email': emailTextController.text});
      } else {
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        var userToken = userData.token.split('\n')[0];
        String decoded = stringToBase64.decode(userToken);
        var decodedStrArr = decoded.split(':');
        homeController.authApiKey.value = decodedStrArr[0];
        homeController.authSecret.value = decodedStrArr[1];
        user.value = userData;

        GetStorage().write('loggedIn', true);
        GetStorage().write('authApiKey', decodedStrArr[0]);
        GetStorage().write('authSecret', decodedStrArr[1]);
        homeController.isLoggedIn.value = true;
        homeController.user.value = userData;
        if (loginScreenType == 1) {
          Get.back();
        } else {
          Get.back();
          Get.back();
        }
        snackbarController =
            new SnackbarController(title: 'Error', message: 'logged_in'.tr);
        snackbarController.showSnackbar();
      }
    } catch (error) {
      print(error);
      Get.back();
      try {
        var errorObj = json.decode(error.toString());
        var statusCode = errorObj['statusCode'];
        var errors = errorObj['errors'];
        if (statusCode == 401 &&
            errors.contains('identity.session.missing_otp')) {
          Get.toNamed('/2fa');
        } else {
          errorController.handleError(error);
        }
      } catch (error) {
        errorController.handleError(error);
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
