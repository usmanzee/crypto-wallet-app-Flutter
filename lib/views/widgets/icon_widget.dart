import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget iconWidget({
  @required String name,
  @required url,
}) {
  return url != null
      ? Image.network(
          url,
          height: 25.0,
          fit: BoxFit.contain,
          width: 22.0,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 40,
              width: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Get.theme.canvasColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${name[0]}${name[1]}'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ),
            );
          },
        )
      : Container(
          height: 40,
          width: 40,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Get.theme.canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              '${name[0]}${name[1]}'.toUpperCase(),
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: Get.theme.textSelectionTheme.selectionColor,
              ),
            ),
          ),
        );
}
