import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textWithIconWidget({
  @required String title,
  @required IconData icon,
  @required String subtitle1,
  @required String subtitle2,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Get.theme.canvasColor,
      // borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Get.theme.textSelectionTheme.selectionColor,
            fontFamily: "Popins",
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  subtitle1,
                  style: TextStyle(
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  subtitle2,
                  style: TextStyle(
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              size: 26,
              color: Get.theme.accentColor,
            ),
          ],
        ),
      ],
    ),
  );
}
