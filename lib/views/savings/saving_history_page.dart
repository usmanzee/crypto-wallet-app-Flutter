import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingHistoryPage extends StatelessWidget {
  final _savingsController = Get.find<SavingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Subscribed Package',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _savingsController.createdSavingsList.length,
              itemBuilder: (context, index) => Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_savingsController.createdSavingsList[index].amount,),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
