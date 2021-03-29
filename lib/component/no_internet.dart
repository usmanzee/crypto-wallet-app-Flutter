import 'package:b4u_wallet/controllers/HomeController.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off,
                size: 64.0, color: Theme.of(context).hintColor),
            Text(
              'no_internet.title'.tr,
              style: TextStyle(
                  fontFamily: "Popins",
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 20),
            ),
            Text(
              'no_internet.desc'.tr,
              style: TextStyle(
                fontFamily: "Popins",
                fontSize: 16,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextButton(
              child: Text(
                'no_internet.button.check'.tr,
              ),
              onPressed: () {},
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  textStyle: TextStyle(fontFamily: "Popins")),
            ),
          ],
        ),
      ),
    );
  }
}
