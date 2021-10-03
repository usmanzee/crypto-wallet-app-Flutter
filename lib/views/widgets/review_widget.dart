import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget reviewWidget({
  @required name,
  @required Function callBack,
  @required IconData icon,
  @required bool green,
}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              size: 25,
              color: green ? Colors.greenAccent : Colors.redAccent,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            name,
            style: TextStyle(
              color: green ? Colors.greenAccent : Colors.redAccent,
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    ),
  );
}
