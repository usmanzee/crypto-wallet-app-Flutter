import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:b4u_wallet/utils/Helpers/readable_message.dart';

class SnackbarController extends GetxController {
  String title;
  String message;

  SnackbarController({this.title, this.message});

  void showSnackbar() {
    ReadAbleMessage newReadAbleMessage = new ReadAbleMessage(message: message);
    var readAbleMessage = newReadAbleMessage.getMessage();
    showToastWidget(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Get.isDarkMode ? Colors.grey[200] : Colors.grey[900],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(
              //   Icons.check,
              //   color: Colors.white,
              // ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                readAbleMessage,
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
        dismissOtherToast: true);
    // Get.snackbar(title, message,
    //     snackPosition: SnackPosition.BOTTOM,
    //     colorText: Colors.white,
    //     backgroundColor: Colors.grey[900]);
  }
}
