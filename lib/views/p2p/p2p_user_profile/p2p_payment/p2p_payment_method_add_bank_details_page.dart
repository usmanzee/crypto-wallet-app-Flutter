import 'dart:convert';

import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pPaymentMethodAddBankDetailsPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();
  final List<TextEditingController> _controller =
      List.generate(6, (i) => TextEditingController());
  RxBool confirm = false.obs;

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
          'Add ${_p2pController.selectedMethodName}',
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
        child: ListView.builder(
          itemCount: _p2pController.selectedPaymentMethodDetails.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => _textField(
            controller: _controller[index],
            hintText:
                _p2pController.selectedPaymentMethodDetails[index].hintText,
            heading:
                _p2pController.selectedPaymentMethodDetails[index].fieldName,
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
            Obx(
              () => GestureDetector(
                onTap: confirm.value
                    ? () async {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        int i = 0;
                        final Map<String, dynamic> initialMap = {};
                        _p2pController.selectedPaymentMethodDetails
                            .forEach((element) {
                          initialMap[element.fieldName] = _controller[i].text;
                          i++;
                        });
                        final Map<String, String> body = {
                          'name': _p2pController.selectedMethodSlug.value,
                        };
                        body['details'] = jsonEncode(initialMap);
                        print(body.toString());
                        print(jsonEncode(body));
                        // final String va = jsonEncode(body);
                        final res = await _p2pController.addPaymentMethod(body);
                        if (res) {
                          Get.back();
                          Get.back();
                          _p2pController.refreshAllAddedPaymentMethods();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Payment Method added successfully'),
                            ),
                          );
                        } else {
                          Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please try again.'),
                            ),
                          );
                        }
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: confirm.value
                        ? Get.theme.accentColor
                        : Get.theme.canvasColor,
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
                        color: confirm.value
                            ? Get.theme.scaffoldBackgroundColor
                            : Get.theme.hintColor,
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

//todo:; add the required parameters and the controllers here
  Widget _textField(
      {@required String heading,
      @required String hintText,
      bool maxLines = false,
      @required TextEditingController controller}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Get.theme.canvasColor,
          ),
          child: TextFormField(
            onChanged: (val) {
              confirmButton();
            },
            controller: controller,
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

  void confirmButton() {
    int count = 0;
    //todo: add the variables here and then send the data to the server.
    for (int i = 0;
        i <= _p2pController.selectedPaymentMethodDetails.length;
        i++) {
      if (_controller[i].text.length >= 4) {
        count++;
      }
    }
    if (count == _p2pController.selectedPaymentMethodDetails.length) {
      confirm.value = true;
    } else {
      confirm.value = false;
    }
  }
}
