import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pSelectPaymentMethodPage extends StatelessWidget {
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
          'Select a payment method',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Get.theme.hintColor,
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended',
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Get.theme.hintColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bank Transfer',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.scaffoldBackgroundColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Get.theme.scaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: GestureDetector(
                onTap: () => Get.toNamed('/p2p_select_all_payment_method_page'),
                child: Text(
                  'All Payment Methods',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.accentColor,
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
