import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexibleTab extends StatelessWidget {
  final date = DateTime.now().subtract(Duration(days: 1));
  final _savingsController = Get.find<SavingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Get.theme.canvasColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Get.theme.canvasColor),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container();
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text('All'),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDialog(
                          context: context,
                          info:
                              'Flexible Savings product subscriptions and redemptions are closed during 23:50-00:10 (UTC) daily. No interest is accumulated on products purchased on the day of subscription. Interest is calculated the next day.');
                    },
                    child: Row(
                      children: [
                        Text(
                          'Flexible deposit timeline',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: _savingsController.plansList.length,
                  // itemCount: 3,
                  itemBuilder: (context, index) {
                    // print('yeah');
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 5.0, right: 5.0),
                      child: _savingsController.plansList[index].type
                                  .toUpperCase() ==
                              'Flexible'.toUpperCase()
                          ? _container(
                              name: _savingsController
                                  .plansList[index].currencyId
                                  .toUpperCase(),
                              annualYield: double.parse(
                                  _savingsController.plansList[index].rate),
                              yesterdayInterest: 23.3,
                              subscriptionCallBack: () {},
                              imageLink: MyImgs.testPhoto,
                              autoSubscriber: true,
                              context: context,
                            )
                          : Container(),
                    );

                    /*_container(
                      name: 'namer'.toUpperCase(),
                      annualYield: 23,
                      yesterdayInterest: 23.3,
                      subscriptionCallBack: () {},
                      imageLink: MyImgs.testPhoto,
                      autoSubscriber: true,
                      context: context,
                    ),
                  );*/
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _container({
    @required String name,
    @required double annualYield,
    @required double yesterdayInterest,
    @required Function subscriptionCallBack,
    @required bool autoSubscriber,
    @required String imageLink,
    @required BuildContext context,
  }) {
    return Obx(() => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        imageLink,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estimated Annual Yield',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Yesterday\'s Interest (${date.month}-${date.day})',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$annualYield',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '$yesterdayInterest',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Get.theme.accentColor,
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Subscribe',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Auto-Subscribe',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          _showDialog(
                            context: context,
                            info:
                                'Every day at 02:00 (UTC + 0), we will use the available balance of all Spot Accounts to purchase Flexible Deposits.',
                          );
                        },
                        child: Icon(
                          Icons.info_outline,
                          size: 20,
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      value: _savingsController.switchValue.value,
                      onChanged: (value) {
                        _savingsController.switchValue.value = value;
                      },
                      activeColor: Get.theme.accentColor,
                      trackColor: Get.theme.hintColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _showDialog({BuildContext context, String info}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          // title: Center(child: Text(heading)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(info),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
