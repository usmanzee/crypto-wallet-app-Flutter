import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pPaymentMethodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
        title: Text(
          'P2P Payment Method(s)',
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.hintColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    MyImgs.testPhoto,
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    'No Payment Method',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: Get.theme.accentColor,
                    borderRadius: BorderRadius.circular(5)),
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Add a payment method',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.scaffoldBackgroundColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
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
