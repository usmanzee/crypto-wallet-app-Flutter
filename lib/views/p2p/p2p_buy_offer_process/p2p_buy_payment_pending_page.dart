import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pBuyPaymentPendingPage extends StatelessWidget {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
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
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
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
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
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
                          ],
                        ),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              second: '70.00 USDT',
                            ),
                            //todo: added animation here data is hardcoded in the widget for now
                            Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _p2pController.clientContainer.value
                                      ? GestureDetector(
                                          onTap: () {
                                            _p2pController
                                                    .clientContainer.value =
                                                !_p2pController
                                                    .clientContainer.value;
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 25,
                                              color: Get.theme.hintColor,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (widget, animation) {
                                      final offsetAnimation = Tween<Offset>(
                                              begin: Offset(0.0, -1),
                                              end: Offset(0.0, 0.0))
                                          .animate(animation);
                                      return ClipRect(
                                        child: SlideTransition(
                                          position: offsetAnimation,
                                          child: widget,
                                        ),
                                      );
                                    },
                                    child: _p2pController.clientContainer.value
                                        ? Container(
                                            key: UniqueKey(),
                                          )
                                        : _container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 8,
                        width: double.infinity,
                        color: Get.theme.canvasColor,
                      ),
                      //todo: add the respective callback here...
                      GestureDetector(
                        onTap: () =>
                            Get.toNamed('/p2p_buy_payment_method_page'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
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
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 32),
                                    child: Text(
                                      'Bank',
                                      style: TextStyle(
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor,
                                        fontFamily: "Popins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: Get.theme.hintColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 8,
                        width: double.infinity,
                        color: Get.theme.canvasColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Terms',
                              style: TextStyle(
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                            //todo: set the required callback here and if necessary add the animated container here for the terms
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 25,
                              color: Get.theme.hintColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //todo: add values and callbacks here according to the requirements
                Positioned(
                  right: 0,
                  bottom: 0,
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
                              color: Get.theme.textSelectionTheme.selectionColor,
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
                              'Cancel',
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
                              'Transfer the fund',
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

  Widget _container() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        _row(
          first: 'Created Time',
          second: '2021-08-04 14:50:12',
        ),
        //todo: add the required variables and the function here
        _row(
          first: 'Seller\'s Nickname',
          second: 'Rana Traders',
          textUnderline: true,
          logoCallback: () {},
          logo: true,
        ),
      ],
    );
  }
}
