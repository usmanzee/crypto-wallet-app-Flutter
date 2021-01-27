import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/models/otp.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';

class OTPController extends GetxController {
  HomeController homeController;
  UserRepository _userRepository;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  TextEditingController otpTextController;
  final _currentStep = 0.obs;
  var user = new User().obs;
  var otp = new Otp().obs;
  var secretKey = ''.obs;
  var disablingOTP = false.obs;

  @override
  void onInit() {
    homeController = Get.find();
    _userRepository = new UserRepository();
    otpTextController = TextEditingController();
    if (!homeController.user.value.otp) {
      fetchOTP();
    }
    super.onInit();
  }

  get currentStep => this._currentStep.value;
  set currentStep(index) => this._currentStep.value = index;

  void fetchUser() async {
    UserRepository _userRepository = new UserRepository();
    var userData = await _userRepository.fetchUser();
    user.value = userData;
  }

  void fetchOTP() async {
    try {
      var otpData = await _userRepository.fetchOTPCode();
      print(otpData.data.url);
      var otpUrl = otpData.data.url;
      var uri = Uri.dataFromString(otpUrl);
      Map<String, String> params = uri.queryParameters;
      secretKey.value = params['secret'];
      otp.value = otpData;
    } catch (error) {
      errorController.handleError(error);
    }
  }

  void enableOTP() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var response =
          await _userRepository.enableOTP({"code": otpTextController.text});
      print(response);
      homeController.user.value.otp = true;
      Get.back();
      Get.back();
      snackbarController =
          new SnackbarController(title: 'Success', message: 'Otp Enabled');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void disableOTP() async {
    try {
      disablingOTP(true);
      var response =
          await _userRepository.disableOTP({'code': otpTextController.text});
      print(response);
      homeController.user.value.otp = false;
      homeController.user.refresh();
      Get.back();
      snackbarController =
          new SnackbarController(title: 'Success', message: 'Otp disabled');
      snackbarController.showSnackbar();

      disablingOTP(false);
    } catch (error) {
      Get.back();
      disablingOTP(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    otpTextController?.dispose();
    snackbarController?.dispose();
    super.onClose();
  }
}
