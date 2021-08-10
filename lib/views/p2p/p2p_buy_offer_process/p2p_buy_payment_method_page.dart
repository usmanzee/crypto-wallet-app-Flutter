import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pBuyPaymentMethodPage extends StatelessWidget {

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
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Pay the seller',
                              style: TextStyle(
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                            //todo: add the required variables
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Time remaining',
                                  style: TextStyle(
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '13:41',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            //todo: add the required variables
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rs',
                                        style: TextStyle(
                                          color: Get.theme.textSelectionTheme
                                              .selectionColor,
                                          fontFamily: "Popins",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Text(
                                          '11,651.50',
                                          style: TextStyle(
                                            color: Get.theme.textSelectionTheme
                                                .selectionColor,
                                            fontFamily: "Popins",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //todo: add the value here for the copying
                                  InkWell(
                                    onTap: () => Clipboard.setData(
                                      ClipboardData(text: "your text"),
                                    ),
                                    child: Icon(
                                      Icons.copy,
                                      size: 15,
                                      color: Get.theme.textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      size: 30,
                                      color: Get.theme.accentColor,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        //todo: add the number here for the chat
                                        child: Text(
                                          '6',
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8.0,
                                            color: Get
                                                .theme.scaffoldBackgroundColor,
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
                                      fontSize: 16.0,
                                      color: Get.theme.textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Container(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Get.theme.canvasColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'The following is the seller\'s payment info. please make sure the money is transferred from an account you own, matching your verified name. Money will NOT be transferred automatically by the platform.',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Container(
                                    color: Colors.yellow,
                                    child: Text(' '),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Bank Transfer',
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Get.theme.hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _row(
                              first: 'Name',
                              second: 'MUHAMMAD ISMAIL',
                            ),
                            _row(
                                first: 'Bank account Number',
                                second: '02180105485107'),
                            _row(
                              first: 'Bank name',
                              second: 'Mezan Bank Limited',
                            ),
                            _row(
                              first: 'Account opening branch',
                              second:
                                  'Bank Account Name: RANA TRADERS AND COMMISSION AGENT IBAN: PK26MEZN0002180105485107',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Get.theme.canvasColor,
                      ),
                      Obx(() => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Terms',
                                  style: TextStyle(),
                                ),
                                InkWell(
                                  onTap: () {
                                    _p2pController.termsContainer.value = ! _p2pController.termsContainer.value;
                                  },
                                  child: Icon(
                                    _p2pController.termsContainer.value ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                    size: 25,
                                    color: Get.theme.hintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (widget, animation) {
                              final offsetAnimation = Tween<Offset>(
                                  begin: Offset(0.0, -1), end: Offset(0.0, 0.0))
                                  .animate(animation);
                              return ClipRect(
                                child: SlideTransition(
                                  position: offsetAnimation,
                                  child: widget,
                                ),
                              );
                            },
                            child: _p2pController.termsContainer.value ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Get.theme.canvasColor,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _container(
                                    heading:
                                    'For a successful transaction, do not enter any crypto-related terms (BTC,etc.) in your payment message.',
                                  ),
                                  _container(
                                    heading:
                                    'ATTENTION! After making the fiat transfer, please click the button below to inform the seller to receive payment, fail to do so will result in automatically cancellation of order and potentially loss of all your asset!',
                                    second: true,
                                  ),
                                ],
                              ),
                            ) : Container(),
                          ),
                        ],
                      ),),
                    ],
                  ),
                ),
                //todo: add values and callbacks here according to the requirements
                Positioned(
                  right: 0,
                  bottom: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Get.theme.canvasColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 3.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Get.theme.accentColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Get.theme.scaffoldBackgroundColor,
                              size: 15,
                            ),
                          ),
                        ),
                        Text(
                          'Tutorial',
                          style: TextStyle(
                            color: Get.theme.textSelectionTheme.selectionColor,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //todo: add values and callbacks here according to the requirements
                Positioned(
                  bottom: 16,
                  left: 32,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Get.theme.canvasColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 15,
                          color: Get.theme.accentColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Identity Verified',
                            style: TextStyle(
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Get.theme.accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 16,
              ),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Get.theme.canvasColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Help',
                              style: TextStyle(
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Get.theme.accentColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Transferred , next',
                              style: TextStyle(
                                color: Get.theme.scaffoldBackgroundColor,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Text(
                first,
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Get.theme.hintColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      second,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () => Clipboard.setData(
                      ClipboardData(text: second),
                    ),
                    child: Icon(
                      Icons.copy,
                      size: 20,
                      color: Get.theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _container({@required String heading, bool second = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: second
              ? Get.theme.accentColor
              : Get.theme.hintColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Get.theme.hintColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '!',
                style: TextStyle(
                  color: Get.theme.scaffoldBackgroundColor,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                child: Text(
                  heading,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: second
                        ? Get.theme.scaffoldBackgroundColor
                        : Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
