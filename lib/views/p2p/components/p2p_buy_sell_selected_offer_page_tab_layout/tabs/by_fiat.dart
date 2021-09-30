import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ByFiat extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();
  final _fiatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8.0,
      ),
      child: Form(
        key: _p2pController.byFiatFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  color: Get.theme.canvasColor,
                  child: Row(
                    children: [
                      //todo: add the icon here after finalizing the json for the icons
                      Text(
                        _p2pController.selectedOffer.baseUnit.toUpperCase(),
                        style: TextStyle(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            _p2pController.byFiatFormKey.currentState
                                .validate();
                          },
                          validator: (value) {
                            if (double.parse(value) >
                                double.parse(_p2pController
                                    .selectedOffer.maxOrderAmount)) {
                              return 'Enter a value lower than the max limit.';
                            }
                            if (double.parse(value) <
                                double.parse(_p2pController
                                    .selectedOffer.minOrderAmount)) {
                              return 'Enter a value higher than the lower limit.';
                            }
                            return null;
                          },
                          controller: _fiatController,
                          maxLines: 1,
                          maxLength: 13,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: 'Enter amount',
                          ),
                        ),
                      ),
                      GestureDetector(
                        //todo: add the value here for the max available in the account.
                        onTap: () {},
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: Get.theme.accentColor,
                            fontSize: 16,
                            fontFamily: 'Popins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 8,
                  ),
                  child: _row(
                    first: 'Quantity',
                    second: _p2pController.selectedOffer.quoteUnit,
                  ),
                ),
                _row(
                  first: 'Amount',
                  second: _p2pController.selectedOffer.baseUnit,
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                if (_p2pController.byFiatFormKey.currentState.validate()) {
                  final res = await _p2pController.createOrderP2p(
                    amount: double.parse(_fiatController.text),
                    offerId: _p2pController.selectedOffer.id,
                  );
                  if (res) {
                    Get.back();
                    _p2pController.startTimer(
                        time: int.parse(_p2pController
                            .createdOrderResponse.offer.timeLimit));
                    Get.toNamed('/p2p_buy_payment_pending_page');
                  } else {
                    Get.back();
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Get.theme.accentColor,
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Buy ${_p2pController.selectedOffer.quoteUnit.toUpperCase()}',
                    style: TextStyle(
                      color: Get.theme.scaffoldBackgroundColor,
                      fontSize: 16,
                      fontFamily: 'Popins',
                      fontWeight: FontWeight.w600,
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

  Widget _row({
    @required String first,
    @required String second,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: TextStyle(
            color: Get.theme.hintColor,
            fontSize: 14,
            fontFamily: 'Popins',
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '--$second',
          style: TextStyle(
            color: Get.theme.accentColor,
            fontSize: 14,
            fontFamily: 'Popins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
