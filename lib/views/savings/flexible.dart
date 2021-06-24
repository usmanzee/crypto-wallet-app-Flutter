import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexibleTab extends StatefulWidget {
  @override
  _FlexibleTabState createState() => _FlexibleTabState();
}

class _FlexibleTabState extends State<FlexibleTab> {
  final date = DateTime.now().subtract(Duration(days: 1));
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  children: [
                    Text('All'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Flexible deposit timelie',
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
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                shrinkWrap: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                    child: _container(
                        name: 'BUSD',
                        annualYield: 2.3,
                        yesterdayInterest: 23.3,
                        subscriptionCallBack: () {},
                        autoSubscriber: true),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  int a = 1;

  Widget _container({
    @required String name,
    @required double annualYield,
    @required double yesterdayInterest,
    @required Function subscriptionCallBack,
    @required bool autoSubscriber,
  }) {
    return Card(
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
                    MyImgs.testPhoto,
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
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      size: 20,
                    ),
                  ),
                ),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog({
    BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          // title: Center(child: Text(heading)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Every day at 02:00 (UTC + 0), we will use the available balance of all Spot Accounts to purchase Flexible Deposits.'),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: ()=> Get.back(),
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
