import 'dart:async';

import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/verification_label.dart';
import 'package:crypto_template/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VerificationController extends GetxController {
  TextEditingController phoneTextController;
  TextEditingController pinCodeTextController;
  HomeController homeController = Get.find();

  var isLoading = false.obs;
  var _codeSent = false.obs;
  var _codeCountDownCompleted = false.obs;
  var labelsList = List<VerificationLabel>().obs;
  var _codeCountDown = 10.obs;
  var phoneNumberText = ''.obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  get codeCountDownCompleted => this._codeCountDownCompleted.value;
  set codeCountDownCompleted(value) =>
      this._codeCountDownCompleted.value = value;

  get codeSent => this._codeSent.value;
  set codeSent(value) => this._codeSent.value = value;

  get codeCountDown => this._codeCountDown.value;
  set codeCountDown(value) => this._codeCountDown.value = value;
  Timer _timer;

  @override
  void onInit() {
    phoneTextController = TextEditingController();
    pinCodeTextController = TextEditingController();
    fetchLabels();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchLabels() async {
    UserRepository _userRepository = new UserRepository();
    try {
      isLoading(true);
      var response = await _userRepository.fetchLables();
      labelsList.assignAll(response);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  void startCodeSentCountDown() {
    _timer?.cancel();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (codeCountDown == 0) {
          timer.cancel();
        } else {
          codeCountDown = codeCountDown - 1;
        }
      },
    );
  }

  void sendPhoneVerificationCode() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    codeCountDown = 60;
    codeSent = true;
    startCodeSentCountDown();
    try {
      var reqObj = {'phone_number': phoneNumberText.value};
      var response = await _userRepository.sendPhoneVerificationCode(reqObj);
      print(response);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.verification.send');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void reSendPhoneVerificationCode() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    codeCountDown = 60;
    codeSent = true;
    startCodeSentCountDown();
    try {
      var reqObj = {'phone_number': phoneNumberText.value};
      var response = await _userRepository.sendPhoneVerificationCode(reqObj);
      codeSent = true;
      print(response);
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.verification.send');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  void verifyPhonePinCode() async {
    UserRepository _userRepository = new UserRepository();
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      var reqObj = {
        'phone_number': phoneNumberText.value,
        'verification_code': pinCodeTextController.text
      };
      var response = await _userRepository.verifyPhonePinCode(reqObj);
      homeController.user.value.level = 2;
      homeController.user.refresh();
      print(response);
      Get.back();
      Get.back();
      snackbarController = new SnackbarController(
          title: 'Success', message: 'success.phone.confirmed');
      snackbarController.showSnackbar();
    } catch (error) {
      Get.back();
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    phoneTextController?.dispose();
    pinCodeTextController?.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
