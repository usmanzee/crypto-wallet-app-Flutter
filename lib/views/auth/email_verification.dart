import 'package:b4u_wallet/controllers/RegisterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var emailAddress = Get.arguments['email'];
    return Scaffold(
      appBar: AppBar(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1.0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'verify_email.screen.title'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 24.0,
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'verify_email.screen.desc'.tr,
                  style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 14.0,
                    color: Theme.of(context).textSelectionColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: Text(
                        'verify_email.screen.button.resend'.tr,
                      ),
                      onPressed: () {
                        controller.resendVerificationCode(emailAddress);
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: TextStyle(fontFamily: "Popins")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
