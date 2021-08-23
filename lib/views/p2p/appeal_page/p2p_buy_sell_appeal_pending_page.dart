import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellAppealPendingPage extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Icon(
              Icons.contacts_outlined,
              size: 20,
              color: Get.theme.hintColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appeal Pending',
                  style: TextStyle(
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ), //todo: add their respective callbacks here
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 25,
                      color: Get.theme.hintColor,
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    Icon(
                      Icons.message,
                      size: 25,
                      color: Get.theme.hintColor,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Text(
                    'Pending response from respondent. Time remaining: ',
                    style: TextStyle(
                      color: Get.theme.textSelectionTheme.selectionColor,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                  //todo: add teh timer here
                  Text(
                    '9:50',
                    style: TextStyle(
                      color: Get.theme.accentColor,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            _textWidget(
              txt:
                  'If both parties have reached an agreement, you can cancel the appeal and proceed to complete the trade',
              number: '1',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _textWidget(
                number: '2',
                txt:
                    'If complainant did not respond in time, CD will get involved and arbitrate.',
              ),
            ),
            _textWidget(
              page: false,
              number: '3',
              txt: 'To provide more information, please ',
              middleText: 'Provide more info.',
              lastText:
                  'Info provided by both users and CS can be found in \"appeal progress\".',
              callback: () {},
            ),
            //todo: add the callback here
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Text(
                  'Cancel the appeal',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textWidget({
    @required String number,
    @required String txt,
    bool page = true,
    Function callback,
    String middleText,
    String lastText,
  }) {
    return Text.rich(
      page
          ? TextSpan(
              children: [
                TextSpan(
                  text: '$number. ',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
                TextSpan(
                  text: txt,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ],
            )
          : TextSpan(
              children: [
                TextSpan(
                  text: '$number. ',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
                TextSpan(
                  text: txt,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
                TextSpan(
                  text: middleText,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.accentColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = callback,
                ),
                TextSpan(
                  text: lastText,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ],
            ),
    );
  }
}
