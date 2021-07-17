import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget questionTile({String question, void Function() callback}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            question,
            style: TextStyle(
              fontFamily: "Popins",
              color: Get.theme.textSelectionTheme.selectionColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Get.theme.hintColor,
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          height: 0.5,
          width: double.infinity,
          color: Get.theme.hintColor,
        ),
      ),
    ],
  );
}
