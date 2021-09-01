import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdSharingCodePage extends StatelessWidget {
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
          'Ad Sharing Code',
          style: TextStyle(
            color: Get.theme.textSelectionTheme.selectionColor,
            fontFamily: "Popins",
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Enter the sharing code to check teh details of the advertisement immediately, and place an order instantly.',
              style: TextStyle(
                color: Get.theme.hintColor,
                fontFamily: "Popins",
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.canvasColor,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    hintText: 'Enter the sharing code',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Get.theme.scaffoldBackgroundColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
