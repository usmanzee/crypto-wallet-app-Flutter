import 'dart:math';

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
            Column(
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
                Text('How the widget will look like'),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _bankWidget(
                      bankName: 'John Doe Company',
                      accountHolderName: 'John Doe',
                      accountNumber: '12345678765430'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () => Get.toNamed('/p2p_select_payment_method_page'),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _bankWidget({
    @required String bankName,
    @required String accountHolderName,
    @required String accountNumber,
  }) {
    final _random = Random();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.primaries[_random.nextInt(Colors.primaries.length)],
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Text(' '),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankName,
                      style: TextStyle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        accountHolderName,
                        style: TextStyle(),
                      ),
                    ),
                    Text(
                      accountNumber,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.edit,
              size: 20,
              color: Get.theme.hintColor,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: double.infinity,
          height: 0.3,
          color: Get.theme.hintColor,
        ),
      ],
    );
  }
}
