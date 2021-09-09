import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexiblePackageDetailPage extends StatelessWidget {
  final _savingsController = Get.find<SavingsController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(_savingsController.flexibleAutoSubscribe.value);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backwardsCompatibility: false,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          foregroundColor: Get.theme.textSelectionTheme.selectionColor,
          centerTitle: true,
          title: Text(
            '${_savingsController.flexibleSelectedOfferCurrencyName.value} Subscribe',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription Amount',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                  TextFormField(
                    controller: _savingsController.flexibleOfferController,
                    decoration: InputDecoration(
                      hintText: 'Please enter the quantity',
                      // border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Get.theme.accentColor,
                          width: 2,
                        ),
                      ),
                      suffix: Text(
                        'Max',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Get.theme.accentColor,
                        ),
                      ),
                    ),
                    cursorColor: Get.theme.accentColor,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        'Available ${_savingsController.flexibleSelectedOfferCurrencyAmount.value} ${_savingsController.flexibleSelectedOfferCurrencyName.value}',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
                      Text(
                        ' Buy Crypto',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Get.theme.accentColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Get.theme.accentColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _row(
                    first: 'Interest calculation time',
                    second:
                        '${_savingsController.flexibleInterestCalculationTime.value}',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: _row(
                      first: '7-Day APY',
                      second:
                          '${_savingsController.flexibleSevenDayApy.value} %',
                    ),
                  ),
                  _row(
                    first: 'Yesterday\'s APY',
                    second:
                        '${_savingsController.flexibleYesterdayApy.value} %',
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _savingsController.flexibleCheck.value =
                              !_savingsController.flexibleCheck.value;
                        },
                        child: Icon(
                          Icons.check_circle,
                          color: _savingsController.flexibleCheck.value
                              ? Get.theme.accentColor
                              : Get.theme.hintColor,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'I have read and agree to ',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
                      GestureDetector(
                        //todo: open the web
                        child: Text(
                          'Orbitex Service Agreement ',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Get.theme.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: _savingsController.flexibleCheck.value
                        ? () async {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );
                            _createSavingsInvestment();
                          }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _savingsController.flexibleCheck.value
                            ? Get.theme.accentColor
                            : Get.theme.canvasColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: _savingsController.flexibleCheck.value
                                ? Get.theme.scaffoldBackgroundColor
                                : Get.theme.hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
            color: Get.theme.hintColor,
          ),
        ),
        Text(
          second,
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ],
    );
  }

  void _createSavingsInvestment() async {
    if (double.parse(
                _savingsController.flexibleOfferController.text.toString()) >
            0.00 &&
        _savingsController.flexibleOfferController.text.isEmpty == false) {
      final res = await _savingsController.createSavingInvestment(
        amount: double.parse(
            _savingsController.flexibleOfferController.text.toString()),
        planId: _savingsController.flexiblePlanId.value,
        autoSubscribe: _savingsController.flexibleAutoSubscribe.value,
        status: 'flexible',
      );
      if (res) {
        _savingsController.flexibleOfferController.clear();

        Get.back();
        Get.back();
      } else {
        Get.back();
      }
    }
  }
}
