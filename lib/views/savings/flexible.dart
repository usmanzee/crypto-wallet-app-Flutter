import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexibleTab extends StatefulWidget {
  @override
  _FlexibleTabState createState() => _FlexibleTabState();
}

class _FlexibleTabState extends State<FlexibleTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: 1,
              itemBuilder: (context, index) {
                return _container(
                    name: 'hi',
                    annualYield: 2.3,
                    yesterdayInterest: 23.3,
                    subscriptionCallBack: () {},
                    autoSubscriber: true);
              },
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                  child: Image.asset(MyImgs.testPhoto,height: 40,width: 40,)
              ),
              Text('BUSD'),
            ],
          ),
        ],
      ),
    );
  }
}
