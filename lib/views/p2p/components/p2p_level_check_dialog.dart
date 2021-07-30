import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void p2pLevelCheckDialog({@required BuildContext context})=> showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              MyImgs.testPhoto,
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
            Text(
              'You have not completed identity verifications. Please complete the verification.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Get
                    .theme
                    .textSelectionTheme
                    .selectionColor,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                //todo: take to the verification screen
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Get
                        .theme.accentColor,
                    width: 1,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                      4),
                ),
                padding: const EdgeInsets
                    .symmetric(
                  vertical: 8,
                ),
                child: Center(
                  child: Text(
                    'Verify Now',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight:
                      FontWeight.w600,
                      fontSize: 18.0,
                      color: Get.theme
                          .accentColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Center(
                child: Text(
                  'Skip for Now',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 18.0,
                    color:
                    Get.theme.hintColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );