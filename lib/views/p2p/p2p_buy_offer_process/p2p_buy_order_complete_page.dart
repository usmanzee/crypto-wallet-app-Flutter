import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuyOrderCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  Icon(
                    Icons.chat,
                    size: 25,
                    color: Get.theme.accentColor,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //todo: add the number here for the chat
                      child: Text(
                        '6',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.bold,
                          fontSize: 8.0,
                          color: Get.theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 4,
                ),
                child: Text(
                  'Chat',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(),
    );
  }
}
