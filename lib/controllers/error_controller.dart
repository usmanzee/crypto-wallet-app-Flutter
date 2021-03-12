import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:get/get.dart';

class ErrorController {
  SnackbarController snackbarController;

  handleError(errorObj) {
    print(errorObj);
    try {
      var errorResponseObj = errorObj.errorResponse();
      print(errorResponseObj);
      snackbarController = new SnackbarController(
          title: 'Error', message: errorResponseObj['message']);
      snackbarController.showSnackbar();
      if (errorResponseObj['originalMessage'] == 'authz.unexistent_apikey') {
        logoutUser();
      }
    } catch (error) {
      print(error);
      snackbarController = new SnackbarController(
          title: 'Error', message: 'server_exception'.tr);
      snackbarController.showSnackbar();
    }
  }

  void logoutUser() async {
    HomeController homeController = Get.find<HomeController>();

    homeController.logoutUser();
  }
}
