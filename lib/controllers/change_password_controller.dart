import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/repository/auth_repository.dart';
import 'package:crypto_template/models/user.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  TextEditingController referralCodeController;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  var user = new User().obs;

  @override
  void onInit() {
    oldPasswordTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    referralCodeController = TextEditingController();
    super.onInit();
  }

  void changePassword() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    AuthRepository _authRepository = new AuthRepository();

    try {
      var requestObject = {
        'old_password': oldPasswordTextController.text,
        'new_password': passwordTextController.text,
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
    oldPasswordTextController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordTextController?.dispose();
    referralCodeController?.dispose();
    super.onClose();
  }
}
