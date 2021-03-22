import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationLevel extends StatelessWidget {
  final VerificationController verificationController =
      Get.find<VerificationController>();
  final HomeController homeController = Get.find<HomeController>();
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
      body: Obx(() {
        if (verificationController.isLoadingLables.value)
          return Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        else
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [Text('Email'), Text('Phone'), Text('Identity')],
              ));
      }),
    );
  }
}
