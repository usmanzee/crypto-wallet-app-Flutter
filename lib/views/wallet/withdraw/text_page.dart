import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Container(
        child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Text('Back')),
      ),
    );
  }
}
