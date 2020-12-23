import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/repository/auth_repository.dart';
import 'package:crypto_template/models/user.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  TextEditingController referralCodeController;
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
      Get.toNamed('/email-verification');
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
