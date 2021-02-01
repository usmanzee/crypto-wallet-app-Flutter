import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:crypto_template/views/verification/phone_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verification extends StatelessWidget {
  final VerificationController verificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'Verification',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PhoneVerification()),
    );
  }
}
