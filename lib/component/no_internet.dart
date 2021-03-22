import 'package:crypto_template/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternet extends StatelessWidget {
  final HomeController homeController = Get.find();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Popins",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
      ),
      body: Center(
        child: Text('No Internet Connection!'),
      ),
    );
  }
}
