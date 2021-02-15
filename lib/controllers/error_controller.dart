import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          title: 'Error', message: 'Something went wrong on the server side');
      snackbarController.showSnackbar();
    }
  }

  void logoutUser() async {
    HomeController homeController = Get.find<HomeController>();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedIn');
    homeController.isLoggedIn.value = false;
    snackbarController = new SnackbarController(
        title: 'Error', message: 'You have been loggedout.');
    snackbarController.showSnackbar();
  }
}
