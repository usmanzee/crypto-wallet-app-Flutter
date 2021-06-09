import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/repository/auth_repository.dart';
import 'package:b4u_wallet/models/user.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  TextEditingController referralCodeController;
  var termsOfUse = true.obs;
  var termsOfUseError = false.obs;
  var passwordVisible = false.obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  var user = new User().obs;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    referralCodeController = TextEditingController();
    super.onInit();
  }

  void register() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    AuthRepository _authRepository = new AuthRepository();

    try {
      var requestObject = {
        'email': emailTextController.text,
        'password': passwordTextController.text,
      };
      if (referralCodeController.text != null &&
          referralCodeController.text != '') {
        requestObject['refid'] = referralCodeController.text;
      }
      user.value = await _authRepository.register(requestObject);
      Get.back();
      Get.toNamed('/email-verification',
          arguments: {'email': emailTextController.text});
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void resendVerificationCode(String email) async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    AuthRepository _authRepository = new AuthRepository();
    try {
      var requestObject = {
        'email': email,
        'lang': 'en',
      };
      await _authRepository.resendVerificationCode(requestObject);
      Get.back();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordTextController?.dispose();
    referralCodeController?.dispose();
    super.onClose();
  }
}
