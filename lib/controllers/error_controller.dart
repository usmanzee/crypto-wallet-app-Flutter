import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ErrorController extends GetxController {
  SnackbarController snackbarController;

  // ErrorController({this.errorObj});

  handleError(errorObj) {
    print(errorObj);
    try {
      var errorResponseObj = errorObj.errorResponse();
      print(errorResponseObj);
      snackbarController = new SnackbarController(
          title: 'Error', message: errorResponseObj['message']);
      snackbarController.showSnackbar();
    } catch (error) {
      print(error);
      snackbarController = new SnackbarController(
          title: 'Error', message: 'Something went wrong on the server side');
      snackbarController.showSnackbar();
    }
  }
}
