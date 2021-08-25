import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pBuySellAppealPendingPage extends StatelessWidget {
  final orderType = 'Sell';
  final currencyType = 'USDT';
  final _p2pController = Get.find<P2pController>();

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
      body: SingleChildScrollView(
        child: Padding(
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
              _p2pController.buyerOrSeller.value
                  ?
                  //todo: add the callback here
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return _dialog();
                              },
                            );
                          },
                          child: Text(
                            'Cancel the appeal',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Negotiation result',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: Get.theme.hintColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Get.theme.hintColor,
                                          width: 0.3,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Negotiation failed',
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Get.theme.hintColor,
                                          width: 0.3,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Consensus reached',
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              GestureDetector(
                onTap: () => Get.toNamed('/p2p_buy_sell_appeal_progress_page'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appeal progress',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Get.theme.accentColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Get.theme.hintColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //todo: add the corresponding text types and colors here according to the order type
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      orderType,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: orderType == 'Sell'
                            ? Colors.redAccent
                            : Colors.greenAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        currencyType,
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
                    ),
                    iconWidget(
                      name: currencyType,
                      url: 'http://url.com',
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.3,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        //todo: replace with the currency symbol here
                        Text(
                          '\$',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                        //todo: replace tithe the amount
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '1234',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //todo: add the amount here to be copied
                            Clipboard.setData(
                              ClipboardData(text: "your text"),
                            );
                          },
                          child: Icon(
                            Icons.copy,
                            size: 20,
                            color: Get.theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _row(
                first: 'Price',
                second: '\$ 123',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _row(
                  first: 'Quantity',
                  second: '123 USDT',
                ),
              ),
              Container(
                height: 8,
                width: double.infinity,
                color: Get.theme.canvasColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buyer\'s Nickname',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    Row(
                      //todo add the buyer's nickname here
                      children: [
                        Text(
                          'buyer Name here',
                          style: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Get.theme.textSelectionTheme.selectionColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Get.theme.hintColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //todo: add the required parameters here
              _row(
                first: 'Created Time',
                second: 'Date here',
              ),
            ],
          ),
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

  Widget _row({
    @required String first,
    @required String second,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          first,
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Get.theme.hintColor,
          ),
        ),
        Text(
          second,
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Get.theme.textSelectionTheme.selectionColor,
          ),
        ),
      ],
    );
  }

  Widget _dialog() {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      actionsPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.only(
        top: 32,
        bottom: 0,
        left: 20,
        right: 20,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Cancel the appeal?',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Once the agreement is confirmed by both parties, the appeal will be canceled.',
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: Get.theme.textSelectionTheme.selectionColor,
              ),
            ),
          ),
          Text(
            '1. Once teh appeal is canceled, users can proceed to complete the order. Canceling the appeal will not result in cancellation of teh order itself.',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Get.theme.hintColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '2. You can file another appeal if you encounter another issue in the future.',
              style: TextStyle(
                fontFamily: "Popins",
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: Get.theme.hintColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.3,
            color: Get.theme.hintColor,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Not Now',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        TextButton(
          child: Text(
            'Cancel the appeal',
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Get.theme.accentColor,
            ),
          ),
          //todo: add the required callback here
          onPressed: () {},
        ),
      ],
    );
  }
}
