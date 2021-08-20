import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdsPageLevelCheckPage extends StatelessWidget {
  //todo: add the logix and the variables here after the talk with the team
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        leading: Container(),
        actions: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.close,
              size: 20,
              color: Get.theme.hintColor,
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
        centerTitle: true,
        title: Text(
          'Trading Requirements',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'To ensure the security of you and your counterparty, you should complete yhe following requirements.',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 25,
                            color: Colors.greenAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              height: 24,
                              width: 0.3,
                              color: Get.theme.hintColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.close_sharp,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable SMS Authentication',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Get.theme.hintColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Finished',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'SMS Authentication failed, Please try again.',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.0,
                                    decoration: TextDecoration.underline,
                                    color: Get.theme.accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 0.3,
                            width: double.infinity,
                            color: Get.theme.hintColor,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Complete KYC Verification',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              color: Get.theme.hintColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Failed',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'KYC verification failed, Please try again.',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.0,
                                    decoration: TextDecoration.underline,
                                    color: Get.theme.accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 0.3,
                            width: double.infinity,
                            color: Get.theme.hintColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Get.theme.canvasColor,
                  ),
                  child: Text(
                    'P2P Trading is not available in the following countries. United States, Republic of Belarus, The Democratic Republic of the Congo, Cuba, Iraq, North Korea, Sudan, Syria, and Zimbawe.',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 11.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
