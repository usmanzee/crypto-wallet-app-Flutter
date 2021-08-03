import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ByFiat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16,),
          color: Get.theme.canvasColor,
          child: Row(
            children: [
              Text('\@'),
              Expanded(child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter amount'
                ),
              ),),
              Text(
                'All',
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
