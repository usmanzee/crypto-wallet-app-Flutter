import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pUserProfile extends StatelessWidget {
  final p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.accentColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 5),
                      child: Text(
                        'a',
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.scaffoldBackgroundColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          18,
                        ),
                        color: Get.theme.textSelectionTheme.selectionColor
                            .withOpacity(0.4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'as*****m.pk',
                            style: TextStyle(
                              fontFamily: "Popins",
                              color: Get.theme.scaffoldBackgroundColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Regular user',
                            style: TextStyle(
                              fontFamily: "Popins",
                              color: Get.theme.scaffoldBackgroundColor,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              categoryVerified(name: 'Email', verified: true),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: categoryVerified(
                                  name: 'SMS',
                                ),
                              ),
                              categoryVerified(
                                name: 'KYC',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(
                        20,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      // left: 16,
                      // right: 16,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p2pController.user30DaysTrades.value
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Get.theme.textSelectionTheme
                                              .selectionColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '30d Trades',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Get.theme.textSelectionTheme
                                              .selectionColor
                                              .withOpacity(0.5),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${p2pController.user30DaysCompletionRate.value}%',
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            color: Get.theme.textSelectionTheme
                                                .selectionColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '30d Completion Rate',
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            color: Get.theme.textSelectionTheme
                                                .selectionColor
                                                .withOpacity(0.5),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  bottom: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Avg Release Time',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed,
                                        fontFamily: "Popins",
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
                                            .withOpacity(0.5),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${p2pController.averageReleaseTime.value} Minutes[s]',
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Avg Pay Time',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dashed,
                                      fontFamily: "Popins",
                                      color: Get.theme.textSelectionTheme
                                          .selectionColor
                                          .withOpacity(0.5),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${p2pController.averagePayTime.value} Minutes[s]',
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      color: Get.theme.textSelectionTheme
                                          .selectionColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              /*Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'More',
                                      style: TextStyle(
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Get.theme.textSelectionTheme
                                          .selectionColor
                                          .withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),*/
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Get.theme.textSelectionTheme.selectionColor
                              .withOpacity(0.5),
                        ),
                        btnRow(
                          name: 'Received Feedback',
                          extra: '0',
                          frontIcon: Icons.thumb_up_outlined,
                          function: () => Get.toNamed('/p2p_feedback_page'),
                        ),
                        btnRow(
                          name: 'Payment Methods',
                          extra: 'Not added',
                          frontIcon: Icons.payment,
                          function: () => Get.toNamed('/p2p_payment_method'),
                        ),
                        btnRow(
                          name: 'P2P Notifications',
                          frontIcon: Icons.notifications_none_outlined,
                          function: () => Get.toNamed('/p2p_notification_setting_page'),
                        ),
                        btnRow(
                          name: 'P2P Help Center',
                          frontIcon: Icons.widgets_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryVerified({
    String name,
    bool verified = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: "Popins",
            color: Get.theme.scaffoldBackgroundColor,
            fontSize: 11.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            color: verified ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.check,
            size: 9,
            color: verified ? Colors.white : Get.theme.accentColor,
          ),
        ),
      ],
    );
  }

  Widget btnRow({
    IconData frontIcon,
    String name,
    String extra = '',
    void Function() function,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: GestureDetector(
        onTap: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  frontIcon,
                  size: 20,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  extra,
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor
                        .withOpacity(0.6),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Get.theme.textSelectionTheme.selectionColor
                      .withOpacity(0.6),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
