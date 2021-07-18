import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pFeedbackPage extends StatelessWidget {
  final p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        backwardsCompatibility: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(
                        color: Get.theme.accentColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'K',
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.scaffoldBackgroundColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 8.0),
                      child: Text(
                        'Khaloofrae',
                        style: TextStyle(
                          fontFamily: "Popins",
                          // color: Get.theme.scaffoldBackgroundColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.thumb_up,
                      color: Colors.green,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        '100.00%',
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Colors.green,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        _container(name: 'All'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _container(name: 'Positive', number: '(11)'),
                        ),
                        _container(name: 'Negative', number: '(0)'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Container(
              color: Get.theme.hintColor,
              height: 1,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Flexible(
            child: ListView.builder(
              // physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return listWidget(
                    name: 'John Doe',
                    comment: 'This is a sample review',
                    date: DateTime.now().toLocal().toString(),
                    positive: false,
                    source: 'BANK');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _container({String name, String number = ''}) {
    return GestureDetector(
      onTap: () {
        p2pController.reviewChosen.value = name;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: p2pController.reviewChosen.value == name
              ? Get.theme.accentColor
              : Get.theme.hintColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            '$name $number',
            style: TextStyle(
              fontFamily: "Popins",
              color: Get.theme.scaffoldBackgroundColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget listWidget(
      {String name,
      String source,
      String date,
      String comment = '',
      bool positive = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, left: 16, right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Get.theme.accentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              name[0],
              style: TextStyle(
                fontFamily: "Popins",
                color: Get.theme.scaffoldBackgroundColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Popins",
                      // color: Get.theme.scaffoldBackgroundColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.hintColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.hintColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        source,
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.hintColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    comment,
                    style: TextStyle(
                      fontFamily: "Popins",
                      // color: Get.theme.scaffoldBackgroundColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Icon(
            positive ? Icons.thumb_up : Icons.thumb_down,
            color: positive ? Colors.greenAccent : Colors.redAccent,
            size: 20,
          ),
        ],
      ),
    );
  }
}
