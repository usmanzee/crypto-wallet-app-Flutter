import 'dart:convert';
import 'dart:math';

import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/models/payment_method/name_helper_model.dart';
import 'package:b4u_wallet/models/payment_method/selected_method_for_offer_model.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentMethodPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

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
          'Select A Payment Method',
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Obx(
          () => Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _p2pController.addedPaymentMethodsList.length > 0
                  ? Expanded(
                      flex: 12,
                      child: GetBuilder<P2pController>(
                        builder: (controller) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.addedPaymentMethodsList.length,
                          itemBuilder: (context, index) => _bankWidget(
                            bankName: controller.addedPaymentMethodsList[index]
                                .paymentMethod.name,
                            accountHolderName: controller
                                .addedPaymentMethodsList[index]
                                .userPaymentDetail,
                            slug: controller.addedPaymentMethodsList[index]
                                .paymentMethod.slug,
                          ),
                        ),
                      ),
                    )
                  : _noMethodsWidget(),
              Expanded(
                flex: 1,
                child: Padding(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bankWidget({
    @required String bankName,
    @required String accountHolderName,
    @required String slug,
  }) {
    final _random = Random();
    final r = NameHelperModel.fromJson(jsonDecode(accountHolderName));
    /*print(r.name);
    if(r.cardSerial != null){
      print('12344');
      print(r.cardSerial);
    }*/
    return InkWell(
      onTap: () {
        _p2pController.selectedMethodForOffer.add(
          SelectedMethodForOfferModel(
            bankName: bankName,
            name: r.name == null ? r.cardSerial : r.name,
            number: r.paymentDetails,
            slug: slug,
          ),
        );
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
                        color: Colors.primaries[
                            _random.nextInt(Colors.primaries.length)],
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
                            r.name == null ? r.cardSerial : r.name,
                            style: TextStyle(),
                          ),
                        ),
                        r.name == null
                            ? Container()
                            : Text(
                                r.paymentDetails,
                                style: TextStyle(),
                              ),
                      ],
                    ),
                  ],
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
        ),
      ),
    );
  }

  Widget _noMethodsWidget() {
    return Expanded(
      flex: 12,
      child: Column(
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
    );
  }
}
