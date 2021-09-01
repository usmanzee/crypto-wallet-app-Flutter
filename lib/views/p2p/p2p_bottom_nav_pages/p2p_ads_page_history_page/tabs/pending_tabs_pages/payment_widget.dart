import 'package:b4u_wallet/views/widgets/line_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //todo:add the variable for the buy or sell and teh color
                    Text(
                      'Sell',
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Colors.redAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'USDT',
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Get.theme.textSelectionTheme.selectionColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //todo: update the status accordingly
                    Text(
                      'Pending payment',
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Get.theme.accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Get.theme.hintColor,
                    ),
                  ],
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
                    'Price',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ), //todo: add the price and the currency here
                  Text(
                    'Rs 198.00',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.hintColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              //todo: add date and time of deal
              Text(
                '08-30 15:54:25',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.hintColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //todo: replace with amount of currency user buying
              Text(
                'Amount 7.57 USDT',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.hintColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              //todo: replace with amount of fiat user giving
              Text(
                'Rs 1500.00',
                style: TextStyle(
                  fontFamily: "Popins",
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Get.theme.canvasColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat,
                        size: 20,
                        color: Get.theme.hintColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Usman',
                        style: TextStyle(
                          fontFamily: "Popins",
                          color: Get.theme.hintColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 20,
                      color: Get.theme.hintColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '14:33',
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Get.theme.hintColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          lineWidget(),
        ],
      ),
    );
  }
}
