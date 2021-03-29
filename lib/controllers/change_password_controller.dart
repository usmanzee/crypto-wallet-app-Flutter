import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordTextController;
  TextEditingController passwordTextController;
  TextEditingController confirmPasswordTextController;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  UserRepository _userRepository;

  @override
  void onInit() {
    oldPasswordTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    super.onInit();
  }

  void changePassword() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      _userRepository = new UserRepository();
      var dataObject = {
        'confirm_password': confirmPasswordTextController.text,
        'old_password': oldPasswordTextController.text,
        'new_password': passwordTextController.text,
      };
      await _userRepository.changePassword(dataObject);
      Get.back();
      Get.back();
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.password.forgot'.tr);
      snackbarController.showSnackbar();
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
    super.onClose();
  }
}
