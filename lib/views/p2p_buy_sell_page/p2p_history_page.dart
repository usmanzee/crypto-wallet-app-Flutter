import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pHistoryPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SafeArea(
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  20.0,
                ),
                bottomLeft: Radius.circular(
                  20.0,
                )),
            color: Colors.black,
          ),
          child: Obx(() {
            return Drawer(
              child: Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            Text(
                              'Order History Filter',
                            ),
                            Icon(
                              Icons.close_rounded,
                              size: 25,
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.6),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            'Type',
                            style: TextStyle(
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.6),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            category(
                              name: 'All',
                              selected: p2pController.typeSelected.value,
                              type: true,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            category(
                              name: 'Buy',
                              selected: p2pController.typeSelected.value,
                              type: true,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            category(
                              name: 'Sell',
                              selected: p2pController.typeSelected.value,
                              type: true,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 32.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            'Status',
                            style: TextStyle(
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.6),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            category(
                              name: 'All',
                              selected: p2pController.statusSelected.value,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            category(
                              name: 'Unpaid',
                              selected: p2pController.statusSelected.value,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            category(
                              name: 'Paid',
                              selected: p2pController.statusSelected.value,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              category(
                                name: 'Completed',
                                selected: p2pController.statusSelected.value,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              category(
                                name: 'Canceled',
                                selected: p2pController.statusSelected.value,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              category(
                                name: 'Appeal Pending',
                                selected: p2pController.statusSelected.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              p2pController.statusSelected.value = 'All';
                              p2pController.typeSelected.value = 'All';
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.3),
                              ),
                              child: Center(
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    color: Get.theme.scaffoldBackgroundColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0,),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Get.theme.accentColor,
                              ),
                              child: Center(
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    color: Get.theme.scaffoldBackgroundColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(
            fontFamily: "Popins",
            // color: Get.theme.scaffoldBackgroundColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _scaffoldKey.currentState.openEndDrawer(),
            child: Icon(
              Icons.filter_alt_outlined,
              size: 25,
              color:
                  Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                MyImgs.testPhoto,
                height: 100,
                width: 100,
              ),
            ),
            Center(
              child: Text(
                'You have no order History.',
                style: TextStyle(
                  fontFamily: "Popins",
                  // color: Get.theme.scaffoldBackgroundColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget category({String name, String selected, bool type = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: type
            ? () {
                p2pController.typeSelected.value = name;
              }
            : () {
                p2pController.statusSelected.value = name;
              },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          decoration: selected == name
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: Get.theme.accentColor,
                      width: 1,
                      style: BorderStyle.solid),
                )
              : BoxDecoration(),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: "Popins",
                // color: Get.theme.scaffoldBackgroundColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
