import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget dropDownMenuWidget() {
  return PopupMenuButton(
    icon: Icon(Icons.more_horiz),
    onSelected: (int value) {
      switch (value) {
        case 3:
          {
            Get.toNamed('/p2p_user_profile');
          }
          break;
        case 1:
          {
            Get.toNamed('/p2p_payment_method');
          }
          break;
        case 2:
          {
            Get.toNamed('/p2p_help_center_page');
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
  );
}
