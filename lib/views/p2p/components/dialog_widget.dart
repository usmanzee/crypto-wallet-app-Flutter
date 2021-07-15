import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final p2pController = Get.find<P2pController>();

Widget dialogWidget({bool iconShow = false}) {
  return Obx(
    () => Material(
      color: Colors.transparent,
      child: Container(
        // padding: const EdgeInsets.only(top: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: p2pController.buySellOrExpress.value
                  ? Get.theme.accentColor
                  : Get.theme.scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: p2pController.buySellOrExpress.value
                                ? Get.theme.scaffoldBackgroundColor
                                : Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Row(
                          children: [
                            Text(
                              p2pController.buySellOrExpress.value
                                  ? 'P2P'
                                  : 'Express',
                              style: TextStyle(
                                fontFamily: "Popins",
                                color: p2pController.buySellOrExpress.value
                                    ? Get.theme.scaffoldBackgroundColor
                                    : Get.theme.textSelectionTheme
                                        .selectionColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.arrow_drop_up,
                              size: 20,
                              color: p2pController.buySellOrExpress.value
                                  ? Get.theme.scaffoldBackgroundColor
                                  : Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          child: Text(
                            'UAH',
                            style: TextStyle(
                              fontFamily: "Popins",
                              color: p2pController.buySellOrExpress.value
                                  ? Get.theme.scaffoldBackgroundColor
                                  : Get.theme.textSelectionTheme.selectionColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: Icon(
                            Icons.swap_horiz,
                            size: 20,
                            color: p2pController.buySellOrExpress.value
                                ? Get.theme.scaffoldBackgroundColor
                                : Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: p2pController.buySellOrExpress.value
                                ? Get.theme.scaffoldBackgroundColor
                                : Get.theme.textSelectionTheme.selectionColor,
                          ),
                          onSelected: (int value) {
                            switch (value) {
                              case 3:
                                {
                                  Get.toNamed('/p2p_user_profile');
                                }
                                break;
                              case 1:
                                {
                                  print('from 1');
                                }
                                break;
                              case 2:
                                {
                                  print('from 2');
                                }
                                break;
                              default:
                                {
                                  print('from default');
                                }
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Payment Methods'),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text('P2P Help Center'),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text('P2P User Center'),
                              value: 3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: p2pController.buySellOrExpress.value
                  ? Get.theme.accentColor
                  : Get.theme.scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      p2pController.buySellOrExpress.value = true;
                      p2pController.buySellOrExpress.refresh();
                      // print(p2pController.buySellOrExpress.value);
                      Get.back();
                    },
                    child: click(
                        name: 'P2P',
                        subtitle: 'More options, more offers',
                        iconShow: p2pController.buySellOrExpress.value
                            ? true
                            : false),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4,),
                    child: Container(
                      height: 1,
                      color: p2pController.buySellOrExpress.value
                          ? Get.theme.scaffoldBackgroundColor
                          : Get.theme.accentColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      p2pController.buySellOrExpress.value = false;
                      p2pController.buySellOrExpress.refresh();
                      // print(p2pController.buySellOrExpress.value);
                      Get.back();
                    },
                    child: click(
                        name: 'Express',
                        subtitle: 'one click buy sell',
                        iconShow: p2pController.buySellOrExpress.value
                            ? false
                            : true),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget click({
  String name,
  String subtitle,
  bool iconShow,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: "Popins",
              color: p2pController.buySellOrExpress.value
                  ? Get.theme.scaffoldBackgroundColor
                  : Get.theme.textSelectionTheme.selectionColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: "Popins",
              color: p2pController.buySellOrExpress.value
                  ? Get.theme.scaffoldBackgroundColor
                  : Get.theme.textSelectionTheme.selectionColor,
              fontSize: 12.0,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      iconShow
          ? Icon(
              Icons.check,
              size: 20,
              color: p2pController.buySellOrExpress.value
                  ? Get.theme.scaffoldBackgroundColor
                  : Get.theme.textSelectionTheme.selectionColor,
            )
          : Container(),
    ],
  );
}
