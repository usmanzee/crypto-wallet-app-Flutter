import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockedPackageDetailsPage extends StatelessWidget {
  final _savingsController = Get.find<SavingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        title: Text(
          '${_savingsController.lockedSelectedOfferCurrencyName.value} Customized Subscription',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Duration',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
