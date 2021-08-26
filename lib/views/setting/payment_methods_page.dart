import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodsPage extends StatelessWidget {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Methods',
                  style: TextStyle(
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'P2P Settings',
                  style: TextStyle(
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  'Buy and Sell crypto instantly through our Peer-to-Peer exchange',
                  style: TextStyle(
                    color: Get.theme.hintColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                _row(
                  first: 'P2P Payment Method(s)',
                  second: 'Not added',
                  callback: () => Get.toNamed('/p2p_payment_method'),
                  secondText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: _row(
                    first: 'P2P Notifications',
                    callback: () =>
                        Get.toNamed('/p2p_notification_setting_page'),
                  ),
                ),
                _row(
                  first: 'P2P Help Center',
                  callback: () => Get.toNamed('/p2p_help_center_page'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: _row(
                    first: 'P2P User Center',
                    callback: () {},
                  ),
                ),
                _row(
                  first: 'Ad sharing Code',
                  callback: () {},
                ),
                //todo: add the required callbacks here for changing the mode of the p2p
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: _row(
                    first: 'Switch Mode',
                    callback: () => showDialog(
                      context: context,
                      builder: (context) => _dialogWidget(
                        orderOrAdvertisement: true,
                      ),
                    ),
                    secondText: true,
                    second: 'Order',
                  ),
                ),
                Text(
                  'Advertisement mode is optimized for users that post advertisements.'
                  ' Order mode is optimized for users that buy and sel'
                  'l from advertisements.',
                  style: TextStyle(
                    color: Get.theme.hintColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 0.3,
            width: double.infinity,
            color: Get.theme.hintColor,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cash Settings',
                  style: TextStyle(
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  'Manage your Cash payment Methods',
                  style: TextStyle(
                    color: Get.theme.hintColor,
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                _row(
                  first: 'Cash Payment Methods',
                  callback: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row({
    @required String first,
    String second,
    bool secondText = false,
    Function callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            first,
            style: TextStyle(),
          ),
          Row(
            children: [
              secondText
                  ? Row(
                      children: [
                        Text(
                          second,
                          style: TextStyle(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    )
                  : Container(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Get.theme.hintColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dialogWidget({@required bool orderOrAdvertisement}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            orderOrAdvertisement
                ? 'Switch to Order mode successfully'
                : 'Switch to Order mode successfully',
            style: TextStyle(
              color: Get.theme.textSelectionTheme.selectionColor,
              fontFamily: "Popins",
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            orderOrAdvertisement
                ? 'Order mode is optimized for users that buy and sell from advertisements'
                : 'Advertisement mode is optimized for users that post advertisements',
            style: TextStyle(
              color: Get.theme.textSelectionTheme.selectionColor,
              fontFamily: "Popins",
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Get.theme.canvasColor,
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Get.theme.textSelectionTheme.selectionColor,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    //todo: add the required callback here
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Get.theme.accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'Go',
                        style: TextStyle(
                          color: Get.theme.scaffoldBackgroundColor,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
