import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pBuyPaymentPendingPage extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Text(
                'Pending Payment',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Time Remaining',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: Get.theme.textSelectionTheme.selectionColor,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                //todo: add the realtime timer here for the offer
                Text(
                  '14:05',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    color: Get.theme.accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              elevation: 3,
              child: Container(
                height: 0.3,
                width: double.infinity,
                color: Get.theme.hintColor.withOpacity(0.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  //todo: add the check here for the buy or sell
                  Text(
                    'Buy',
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
                        color: Get.theme.textSelectionTheme.selectionColor,
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
            //todo: add teh currency and the currency unit here in the second text
            _row(
              first: 'Fiat Amount',
              second: 'RS 11,651.50',
              biggerText: true,
            ),
            //todo: add the per unit price here and the currency symbol
            _row(
              first: 'Price',
              second: 'RS 166.45',
            ),
            _row(
              first: 'Crypto Amount',
              second: 'RS 166.45',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Container(
                height: 0.3,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
            ),
            //todo: add the order number here from the order
            _row(
              first: 'Order Number',
              second: '20256173861735276544',
              logo: true,
              icon: Icons.copy,
              logoCallback: () {
                //todo: add the order number here from the order to be copied
                Clipboard.setData(ClipboardData(text: "your text"));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _row({
    @required String first,
    @required String second,
    bool biggerText = false,
    bool logo = false,
    Function logoCallback,
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
            children: [
              Text(
                second,
                style: TextStyle(
                  color: Get.theme.textSelectionTheme.selectionColor,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: biggerText ? 18.0 : 14,
                ),
              ),
              logo ? Icon(icon) : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
