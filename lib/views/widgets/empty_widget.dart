import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
          height: 100,
          width: 100,
          child: Placeholder(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'You have no order history.',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Get.theme.hintColor,
            ),
          ),
        )
      ],
    );
  }
}
