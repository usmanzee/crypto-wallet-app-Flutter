import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellAppealPendingPage extends StatelessWidget {
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Icon(
              Icons.contacts_outlined,
              size: 20,
              color: Get.theme.hintColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Appeal Pending'),
              ],
            ),
            Row(
              children: [
                Text(
                  'Pending response from respondent. Time remaining: ',
                  style: TextStyle(),
                ),
                Text(
                  '9:50',
                  style: TextStyle(
                    color: Get.theme.hintColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
