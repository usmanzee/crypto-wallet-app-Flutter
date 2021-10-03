import 'dart:math';

import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/widgets/line_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostAddSecondPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();
  final _random = Random();
  final List<TimeValues> _timeValues = [
    TimeValues('15 Min', 15),
    TimeValues('30 Min', 30),
    TimeValues('45 Min', 45),
    TimeValues('1 Hour', 60),
    TimeValues('2 Hour', 120),
    TimeValues('3 Hour', 180),
    TimeValues('6 Hour', 360),
    TimeValues('12 Hour', 720),
    TimeValues('1 Day', 1440),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Form(
          key: _p2pController.secondFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total amount',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Get.theme.hintColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _p2pController
                                  .secondTotalAmountTextController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _p2pController.secondFormKey.currentState
                                    .validate();
                                if (double.parse(value) == 0) {
                                  return;
                                } else {
                                  _p2pController.secondAddedAmountInFiat.value =
                                      value;
                                  _p2pController.secondAddedAmountInFiatCheck.value =
                                  (double.parse(value) * double.parse(_p2pController.firstLowestPrize.value)).toStringAsFixed(2);

                                }
                              },
                              validator: (value) {
                                if (double.parse(value) >
                                    double.parse(_p2pController
                                        .secondAvailableAmount.value)) {
                                  return 'Please enter an amount below the available';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                _p2pController
                                        .secondTotalAmountTextController.text =
                                    _p2pController.secondAvailableAmount.value;
                                _p2pController.secondAddedAmountInAsset.value =
                                    _p2pController.secondAvailableAmount.value;
                              },
                              child: Text(
                                'All',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Get.theme.accentColor,
                                ),
                              ),
                            ),
                          ),
                          //todo: selected currency name will be shown here
                          Text(
                            _p2pController.firstSelectedAsset.value,
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => Text(
                            '≈ ${_p2pController.secondAddedAmountInFiatCheck.value} ',
                            // '≈ value here',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ),
                        Text(
                          '${_p2pController.firstSelectedFiat}',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Available: ',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.hintColor,
                          ),
                        ),
                        Text(
                          '${_p2pController.secondAddedAmountInAsset} ${_p2pController.firstSelectedAsset}',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Order Limit',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Get.theme.hintColor,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Get.theme.hintColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        _textWidget(
                            controller:
                                _p2pController.secondOrderLimitFirstController),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '~',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Get.theme.hintColor,
                            ),
                          ),
                        ),
                        _textWidget(
                            controller: _p2pController
                                .secondOrderLimitSecondController),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Container(
                  height: 4,
                  width: double.infinity,
                  color: Get.theme.hintColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Method',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Get.theme.hintColor,
                              ),
                            ),
                            Text(
                              'Select up to 5 methods.',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                color: Get.theme.hintColor,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () =>
                              Get.toNamed('/select_payment_method_page'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Get.theme.hintColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '+ Add',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: _p2pController.selectedMethodForOffer.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _paymentMethodWidget(
                          bankName: _p2pController
                              .selectedMethodForOffer[index].bankName,
                          ownerName:
                              _p2pController.selectedMethodForOffer[index].name,
                          accountNumber: _p2pController
                              .selectedMethodForOffer[index].number,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => _timeWidget(),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Payment Time Limit',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Get.theme.hintColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: Get.theme.hintColor,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${_p2pController.secondTimeLimitString.value}',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: Get.theme.hintColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 4,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textWidget({@required TextEditingController controller}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Get.theme.hintColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  _p2pController.secondFormKey.currentState.validate();
                },
                validator: (value) {
                  if (double.parse(value) >
                      double.parse(_p2pController.secondAddedAmountInFiatCheck.value)) {
                    return 'Please enter a value lower than the total amount';
                  }
                  if(value.length == 0){
                    return 'please enter a valid value';
                  }
                  if(value == null){
                    return 'please enter a valid value';
                  }
                  if(double.parse(value) == 0){
                    return 'please enter a valid value';
                  }
                  return null;
                },
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            Text(
              _p2pController.firstSelectedFiat.value,
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Get.theme.textSelectionTheme.selectionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeWidget() {
    return Container(
      width: double.infinity,
      height: Get.height * 0.5,
      color: Get.theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select the time duration',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: lineWidget(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _timeValues.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => _timerValueWidget(
                time: _timeValues[index].time,
                value: _timeValues[index].value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timerValueWidget({@required String time, @required int value}) {
    return GestureDetector(
      onTap: () {
        _p2pController.secondTimeLimitString.value = time;
        _p2pController.secondTimeLimitInt.value = value;
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Get.theme.hintColor, width: 0.3),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentMethodWidget({
    @required String bankName,
    @required String ownerName,
    @required String accountNumber,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors
                          .primaries[_random.nextInt(Colors.primaries.length)],
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: Text(' '),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    bankName,
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  _p2pController.selectedMethodForOffer
                      .removeWhere((item) => item.number == accountNumber);
                },
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Get.theme.hintColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              ownerName,
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Get.theme.hintColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              accountNumber,
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Get.theme.hintColor,
              ),
            ),
          ),
          lineWidget(),
        ],
      ),
    );
  }
}

class TimeValues {
  String time;
  int value;

  TimeValues(this.time, this.value);
}
