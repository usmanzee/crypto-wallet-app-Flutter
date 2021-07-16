import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pNotificationsSettingPage extends StatelessWidget {
  final p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.textSelectionTheme.selectionColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            categories(
              subtitle:
                  'To receive news about new orders and order status changes, please enable at least 1 notification',
              heading: 'Orders',
              appNotification: p2pController.ordersAppNotificationsEnable,
              email: p2pController.ordersEmailEnable,
              sms: p2pController.ordersSmsEnable,
            ),
            categories(
              subtitle:
              'To receive news about new appeals and appeal status changes, please enable at least 1 notification',
              heading: 'Appeals',
              appNotification: p2pController.appealsAppNotificationsEnable,
              email: p2pController.appealsEmailEnable,
              sms: p2pController.appealsSmsEnable,
            ),
            categories(
              subtitle:
              'Receive security and privacy reminders and other messages, emails and text messages cannot be closed manually',
              heading: 'Security',
              appNotification: p2pController.securityAppNotificationsEnable,
              email: p2pController.securityEmailEnable,
              sms: p2pController.securitySmsEnable,
            ),
          ],
        ),
      ),
    );
  }

  Widget categories(
      {String heading,
      String subtitle,
      RxBool sms,
      RxBool appNotification,
      RxBool email}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.hintColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    option(
                      name: 'Email',
                      value: email,
                    ),
                    option(
                      name: 'SMS',
                      value: sms,
                    ),
                    option(
                      name: 'App Notifications',
                      value: appNotification,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: Get.theme.hintColor.withOpacity(0.6),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget option({String name, RxBool value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: "Popins",
              color: Get.theme.textSelectionTheme.selectionColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              value: value.value,
              onChanged: (v) {
                value.value = v;
              },
              activeColor: Get.theme.accentColor,
            ),
          )
        ],
      ),
    );
  }
}
