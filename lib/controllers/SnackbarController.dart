import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackbarController extends GetxController {
  String title;
  String message;

  SnackbarController({this.title, this.message});

  void showSnackbar() {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.grey[900]);
  }
}
