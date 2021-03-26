import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/swap_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ErrorController {
  SnackbarController snackbarController;

  handleError(errorResponseString) {
    try {
      var errorObj = json.decode(errorResponseString.toString());
      var statusCode = errorObj['statusCode'];
      var errors = errorObj['errors'];
      print(errors);
      switch (statusCode) {
        case 401:
          if (errors.contains('identity.session.not_active')) {
            logoutUser();
          } else {
            if (errors.contains('authz.invalid_session')) {
              logoutUser();
            } else {
              if (errors.contains('authz.client_session_mismatch') ||
                  errors.contains('authz.csrf_token_mismatch') ||
                  errors.contains('authz.unexistent_apikey') ||
                  errors.contains('authz.apikey_not_active')) {
                logoutUser();
              } else {
                showMessage(errors);
                break;
              }
            }
          }
          break;

        case 403:
          if (errors.contains('identity.session.invalid_otp') > -1) {
            showMessage(errors);
          }
          if (errors.contains('jwt.decode_and_verify') > -1) {
            showMessage(errors);
          }
          break;

        case 429:
          showMessage(errors);
          break;
        case 422:
        default:
          showMessage(errors);
      }
    } catch (error) {
      snackbarController = new SnackbarController(
          title: 'Error', message: 'server_exception'.tr);
      snackbarController.showSnackbar();
    }
  }

  void showMessage(errors) {
    for (var error in errors) {
      snackbarController =
          new SnackbarController(title: 'Error', message: error.toString().tr);
      snackbarController.showSnackbar();
    }
  }

  void logoutUser() async {
    HomeController homeController = Get.find<HomeController>();
    if (homeController.isLoggedIn.value) {
      isHomeScreen();
      homeController.logoutUser();
    }
  }

  void isHomeScreen() {
    HomeController homeController = Get.find<HomeController>();
    homeController.selectedNavIndex = 0;
    bool tradingControllerInstance = Get.isRegistered<TradingController>();
    if (tradingControllerInstance) {
      Get.delete<TradingController>(force: true);
    }
    bool swapControllerInstance = Get.isRegistered<SwapController>();
    if (swapControllerInstance) {
      Get.delete<SwapController>(force: true);
    }
    if (Get.currentRoute != '/home') {
      Get.back();
      isHomeScreen();
    }
  }
}
