import 'package:b4u_wallet/models/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget IconWidget({@required String name,@required url,}){
  return Image.network(
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
          child: Text('${name[0]}${name[1]}',style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),),
        ),
      );
    },
  );
}