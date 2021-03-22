import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';

class ForgetPasswordController extends GetxController {
  UserRepository userRepository;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  TextEditingController emailTextController;
  var user = new User().obs;

  @override
  void onInit() {
    userRepository = new UserRepository();
    emailTextController = TextEditingController();
    super.onInit();
  }

  void sendPasswordResetLink() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var response = await userRepository.sendPasswordResetLink({
        'email': emailTextController.text,
      });
      print(response);
      Get.back();
      // emailTextController.clear();
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
    emailTextController?.dispose();
    snackbarController?.dispose();
    super.onClose();
  }
}
