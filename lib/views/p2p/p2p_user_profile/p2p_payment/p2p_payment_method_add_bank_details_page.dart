import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pPaymentMethodAddBankDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        //todo: add the bank name here
        title: Text(
          'Add ABN AMRO',
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
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textField(
                hintText: 'Please enter your full name',
                heading: 'Full name',
              ),
              _textField(
                hintText: 'Please fill in your bank account number',
                heading: 'Bank account number',
              ),
              _textField(
                hintText:
                    'details like your own address, the address of the bank, the IBAN code and SWIFTBIC code, etc.',
                heading:
                    'Other payment details (for internation transfer) (Optional)',
                maxLines: true,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        color: Get.theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tip: The added payment method will be shown to the buyer during the transaction to accept Fiat transfers. Please make sure the information is correct.',
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 11.0,
                color: Get.theme.hintColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.canvasColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Get.theme.hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//todo:; add the required parameters and the controllers here
  Widget _textField({
    @required String heading,
    @required String hintText,
    bool maxLines = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Text(
          heading,
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: Get.theme.hintColor.withOpacity(0.8),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Get.theme.canvasColor,
          ),
          child: TextFormField(
            maxLines: maxLines ? 5 : 1,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: Get.theme.hintColor.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
