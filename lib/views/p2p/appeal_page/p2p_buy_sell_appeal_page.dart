import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellAppealPage extends StatelessWidget {
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
          'Appeal',
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
    );
  }
}
