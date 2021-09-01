import 'package:b4u_wallet/views/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pSellerOfferCompletePage extends StatelessWidget {
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
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Container(
                height: 100,
                width: 100,
                child: Placeholder(),
              ),
            ),
            Text(
              'Rs 1,500.00',
              style: TextStyle(
                fontFamily: "Popins",
                color: Get.theme.textSelectionTheme.selectionColor,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 48,
              ),
              child: Text(
                'Successfully sold 7.75 USDT',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.scaffoldBackgroundColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Check wallet',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.accentColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      //todo: add the required parameters here
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: Get.theme.hintColor,
              width: 0.3,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                'How was your trading experience',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ),
            Row(
              children: [
                reviewWidget(
                  icon: Icons.thumb_up_outlined,
                  callBack: () {},
                  name: 'Positive',
                  green: true,
                ),
                const SizedBox(
                  width: 16,
                ),
                reviewWidget(
                  name: 'Negative',
                  callBack: () {},
                  icon: Icons.thumb_down_outlined,
                  green: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
