import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pBuyOrderCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: false,
        backgroundColor: Colors.greenAccent,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //todo: add teh required variables here
                  Container(
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order completed',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'You successfully purchased 70.00 USDT',
                              style: TextStyle(
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 30,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //todo: add the required variables here
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              //todo: add the check here for the buy or sell
                              Text(
                                'BUY',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                              ),
                              //todo: add the name for the currency from the controller
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 4,
                                ),
                                child: Text(
                                  'USDT',
                                  style: TextStyle(
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              //todo: get the link for the icon from the controller or the post
                              iconWidget(name: 'USDT', url: 'url'),
                            ],
                          ),
                        ),
                        //todo: add the per unit price here and the currency symbol
                        _rowWidget(
                          first: 'Fiat Amount',
                          second: 'RS 11,651.50',
                          biggerText: true,
                        ),
                        //todo: add the per unit price here and the currency symbol
                        _rowWidget(
                          first: 'Price',
                          second: 'RS 166.45',
                        ),
                        //todo: add the per unit price here and the currency symbol
                        _rowWidget(
                          first: 'Crypto Amount',
                          second: '70.00 USDT',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Get.theme.canvasColor,
                          ),
                        ),
                        //todo: add the order number here from the order
                        _rowWidget(
                          first: 'Order Number',
                          second: '20256173861735276544',
                          logo: true,
                          icon: Icons.copy,
                          logoCallback: () {
                            //todo: add the order number here from the order to be copied
                            Clipboard.setData(ClipboardData(text: "your text"));
                          },
                        ),
                        _rowWidget(
                          first: 'Created Time',
                          second: '2021-08-04 14:50:12',
                        ),
                        //todo: add the required variables and the function here
                        _rowWidget(
                          first: 'Seller\'s Nickname',
                          second: 'Rana Traders',
                          textUnderline: true,
                          logoCallback: () {},
                          logo: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: Get.theme.canvasColor,
                  ),
                  //todo: add the per unit price here and the currency symbol
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Payment method',
                          style: TextStyle(),
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.yellow,
                              child: Text(' '),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 32),
                              child: Text(
                                'Bank',
                                style: TextStyle(
                                  color: Get.theme.hintColor,
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: Get.theme.canvasColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      'How was your trading experience',
                      style: TextStyle(
                        color: Get.theme.textSelectionTheme.selectionColor,
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Get.theme.canvasColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Get.theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(
                                    Icons.thumb_up_outlined,
                                    size: 25,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  'Positive',
                                  style: TextStyle(
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Get.theme.canvasColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Get.theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Icon(
                                    Icons.thumb_down_outlined,
                                    size: 25,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  'Negative',
                                  style: TextStyle(
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
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
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    color: Get.theme.canvasColor,
                    child: Center(
                      child: Text(
                        'Appeal',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
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

  Widget _rowWidget({
    @required String first,
    @required String second,
    bool biggerText = false,
    bool logo = false,
    bool textUnderline = false,
    void Function() logoCallback,
    IconData icon = Icons.arrow_forward_ios,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            first,
            style: TextStyle(
              color: Get.theme.hintColor,
              fontFamily: "Popins",
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                second,
                style: TextStyle(
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: biggerText ? 18.0 : 14,
                  decoration: textUnderline
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
              logo
                  ? InkWell(
                      onTap: logoCallback,
                      child: Icon(
                        icon,
                        size: 15,
                        color: Get.theme.hintColor,
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
