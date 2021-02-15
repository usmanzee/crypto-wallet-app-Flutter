import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:crypto_template/models/verification_label.dart';
import 'package:crypto_template/views/verification/document_verification.dart';
import 'package:crypto_template/views/verification/identity_verification.dart';
import 'package:crypto_template/views/verification/phone_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verification extends StatelessWidget {
  final VerificationController verificationController = Get.find();
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
                child: renderContent());
        }));
  }

  Widget renderContent() {
    var labels = verificationController.labelsList;
    VerificationLabel isProfileVerified = labels.firstWhere(
        (label) =>
            label.key == 'profile' &&
            (label.value == 'verified' || label.value == 'submitted') &&
            label.scope == 'private',
        orElse: () => null);

    var level = homeController.user.value.level;
    switch (level) {
      case 1:
        return PhoneVerification();
      case 2:
        return isProfileVerified != null
            ? DocumentVerification()
            : IdentityVerification();
      case 3:
        return DocumentVerification();
      default:
        return Text('Something went wrong!');
    }
  }
}
