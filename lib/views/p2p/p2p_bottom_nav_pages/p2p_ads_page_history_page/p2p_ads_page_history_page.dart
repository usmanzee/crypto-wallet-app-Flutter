import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdsPageHistoryPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Ads History',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
          ),
          Container(
            width: 100,
            height: 100,
            child: Placeholder(),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'You have no Ad history yet.',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
        ],
      ),
    );
  }
}
