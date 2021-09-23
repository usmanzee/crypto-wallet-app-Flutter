import 'dart:math';

import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pSelectAllPaymentMethodPage extends StatelessWidget {
  final Random random = Random();
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
          'All Payment Methods',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Get.theme.hintColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            final a = _p2pController.addedPaymentMethodsList[0].paymentMethod.slug;
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Get.theme.canvasColor,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 20,
                    color: Get.theme.hintColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter a payment method.',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: _p2pController.publicPaymentMethodList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      final res =
                          await _p2pController.selectedPublicMethodDetails(
                              selectedMethod: _p2pController
                                  .publicPaymentMethodList[index].slug);
                      Get.back();
                      if (res) {
                        _p2pController.selectedMethodName.value = _p2pController
                            .publicPaymentMethodList[index].name;
                        _p2pController.selectedMethodSlug.value = _p2pController
                            .publicPaymentMethodList[index].slug;
                        Get.toNamed(
                            '/p2p_payment_method_add_bank_details_page');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('please try again'),
                          ),
                        );
                      }
                    },
                    child: ListItem(
                      name: _p2pController.publicPaymentMethodList[index].name,
                      random: random,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String name;
  final Random random;

  ListItem({@required this.name, @required this.random});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.primaries[random.nextInt(Colors.primaries.length)],
              borderRadius: BorderRadius.circular(1),
            ),
            child: Text(' '),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 0.3,
                  width: double.infinity,
                  color: Get.theme.hintColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
