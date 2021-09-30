import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class P2pBuyPaymentPendingPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    print(_p2pController.createdOrderResponse.offer.toJson());
    print(_p2pController.createdOrderResponse.toJson());
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
          InkWell(
            onTap: () => Get.toNamed('/p2p_chat_page'),
            child: Row(
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
                        child: Text(
                          ' ',
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
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
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
                                Obx(
                                  () => Text(
                                    '${((_p2pController.offerTime.value / 60) % 60).toInt().toString().padLeft(2, '0')} : ${(_p2pController.offerTime.value % 60).toInt().toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                      color: Get.theme.accentColor,
                                    ),
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
                                  Text(
                                    _p2pController
                                        .createdOrderResponse.offer.side
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: _p2pController.createdOrderResponse
                                                  .offer.side ==
                                              'sell'
                                          ? Colors.redAccent
                                          : Colors.greenAccent,
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
                                      'missing'.toUpperCase(),
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
                            _rowWidget(
                              first: 'Fiat Amount',
                              second:
                                  '${_p2pController.createdOrderResponse.offer.baseUnit} ${_p2pController.createdOrderResponse.amount}',
                              biggerText: true,
                            ),
                            _rowWidget(
                              first: 'Price',
                              second:
                                  '${_p2pController.createdOrderResponse.offer.baseUnit} ${_p2pController.createdOrderResponse.offer.price}',
                            ),
                            _rowWidget(
                              first: 'Crypto Amount',
                              second:
                                  '${double.parse(_p2pController.createdOrderResponse.offer.availableAmount).toStringAsFixed(2)} Missing',
                            ),
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
                        onTap: () {
                          //todo: add the callback here for the check if there is one or more payment methods
                          /*showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) {
                              return _bottomSheet();
                            },
                          );*/
                          return Get.toNamed('/p2p_buy_payment_method_page');
                        },
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
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        context: context,
                        builder: (context) {
                          return _bottomSheet();
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
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
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
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
                top: 6,
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
                            vertical: 6,
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
                        child: GestureDetector(
                          onTap: () =>
                              Get.toNamed('/p2p_buy_payment_release_page'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
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
        _rowWidget(
          first: 'Order Number',
          second: _p2pController.createdOrderResponse.id.toString(),
          logo: true,
          icon: Icons.copy,
          logoCallback: () {
            Clipboard.setData(
              ClipboardData(
                  text: _p2pController.createdOrderResponse.id.toString()),
            );
          },
        ),
        _rowWidget(
          first: 'Created Time',
          second: _p2pController.createdOrderResponse.createdAt.toLocal().toString(),
        ),
        //todo: add the required variables and the function here
        _rowWidget(
          first: 'Seller\'s Nickname',
          second: 'Missing',
          textUnderline: true,
          logoCallback: () {},
          logo: true,
        ),
      ],
    );
  }

  Widget _bottomSheet() {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    'Select payment method',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      size: 25,
                      color: Get.theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 0.5,
                width: double.infinity,
                color: Get.theme.hintColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    //todo: add the callback here for the payment method page
                    onTap: () {},
                    child: _listWidget(
                        title: 'Bank Transfer',
                        name: 'name',
                        accountNumber: 'accountNumber'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listWidget(
      {@required String title,
      @required String name,
      @required String accountNumber}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.yellow,
                child: Text(
                  ' ',
                  style: TextStyle(
                      // height: 1,
                      // fontFamily: "Popins",
                      // fontWeight: FontWeight.w600,
                      // fontSize: 16.0,
                      // color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      height: 1.4,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.textSelectionTheme.selectionColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      accountNumber,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          width: double.infinity,
          color: Get.theme.hintColor,
        ),
      ],
    );
  }
}
