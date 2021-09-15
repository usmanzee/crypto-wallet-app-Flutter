import 'dart:math';

import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdsPage extends StatelessWidget {
  // final _p2pController = Get.find<P2pController>();
  final _homeController = Get.find<HomeController>();
  final RxString _selectedElement = ''.obs;

  //todo: replace it with the data from the server to change it from teh listview
  RxBool online = false.obs;
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
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
        centerTitle: true,
        title: Text(
          'My Ads',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Get.theme.hintColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: checkAndTake,
            child: Icon(
              Icons.add,
              size: 25,
              color: Get.theme.hintColor,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/p2p_ads_page_history_page'),
            child: Icon(
              Icons.history,
              size: 25,
              color: Get.theme.hintColor,
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _element(
                  callback: () {
                    _selectedElement.value = 'Cryptos';
                    _showDialog(context: context);
                  },
                  name: 'Cryptos',
                ),
                _element(
                  callback: () {
                    _selectedElement.value = 'Types';
                    _showDialog(context: context);
                  },
                  name: 'Types',
                ),
                _element(
                  callback: () {
                    _selectedElement.value = 'Status';
                    _showDialog(context: context);
                  },
                  name: 'Status',
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Get.theme.canvasColor,
          ),
          //todo: listview with the values
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => _offerWidget(
                  type: 'Sell',
                  asset: 'USDT',
                  fiat: 'PKR',
                  status: online,
                  fiatCurrency: 'Rs',
                  priceInFiat: '198.00',
                  totalAmount: '162.43',
                  lowerLimit: '1500.00',
                  upperLimit: '150000.00',
                  bankName: 'Easypaisa-PK Only',
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 100,
              ),
              //todo: add the picture here
              Container(
                width: 100,
                child: Image.asset(
                  MyImgs.testPhoto,
                  height: 100,
                  width: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'You do not have any Ads.',
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    color: Get.theme.hintColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: checkAndTake,
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.accentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(
                    'Post Ad',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Get.theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          /*//todo: the confirm payment received dialog
          ElevatedButton(
            onPressed: () => showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Confirm Payment Received',
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'ATTENTION! Please be sure to LOG IN THE RECEIVING (e.g. Banks/ eWallet) ACCOUNT to confirm that the money has arrived in the \"Available Balance\"',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Get.theme.textSelectionTheme.selectionColor,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Get.theme.hintColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'I confirm that the payment is successfully received with the correct amount and sender information',
                            style: TextStyle(
                              fontFamily: "Popins",
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color:
                                  Get.theme.textSelectionTheme.selectionColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Get.theme.canvasColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Get.theme.canvasColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Get
                                      .theme.textSelectionTheme.selectionColor,
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
            child: Text('dialog'),
          ),
          //todo: the requirements screen
          ElevatedButton(
            onPressed: () => Get.toNamed('/p2p_ads_page_level_check_page'),
            child: Text('level check'),
          ),*/
        ],
      ),
    );
  }

  Widget _element({
    @required String name,
    Function callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: "Popins",
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: _selectedElement.value == name
                  ? Get.theme.accentColor
                  : Get.theme.textSelectionTheme.selectionColor,
            ),
          ),
          Icon(
            _selectedElement.value == name
                ? Icons.arrow_drop_up
                : Icons.arrow_drop_down,
            size: 15,
            color: _selectedElement.value == name
                ? Get.theme.accentColor
                : Get.theme.hintColor,
          ),
        ],
      ),
    );
  }

  void _showDialog({
    @required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 56),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.5,
              backwardsCompatibility: false,
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              foregroundColor: Get.theme.textSelectionTheme.selectionColor,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                  color: Get.theme.hintColor,
                ),
              ),
              centerTitle: true,
              title: Text(
                'My Ads',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Get.theme.hintColor,
                ),
              ),
              actions: [
                GestureDetector(
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Get.theme.hintColor,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.history,
                    size: 25,
                    color: Get.theme.hintColor,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Obx(
                    () => Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _element(
                            name: 'Cryptos',
                          ),
                          _element(
                            name: 'Types',
                          ),
                          _element(
                            name: 'Status',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Get.theme.canvasColor,
                ),
                Flexible(
                  child: Container(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        print('from listview');
                        Get.back();
                      },
                      child: ListView.builder(
                        itemCount: 100,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //todo: add the variables here and also add the other functionality
                          return _listWidget(
                            name: 'hi',
                            callback: () {},
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listWidget({String name, Function callback}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        color: Get.theme.scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    //todo: add the condition here for the done marker
                    Icon(
                      Icons.done,
                      color: Get.theme.accentColor,
                      size: 20,
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
          ),
        ),
      ),
    );
  }

  Widget _offerWidget({
    @required String type,
    @required String asset,
    @required String fiat,
    @required RxBool status,
    @required String fiatCurrency,
    @required String priceInFiat,
    @required String totalAmount,
    @required String lowerLimit,
    @required String upperLimit,
    @required String bankName,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: type == 'Sell'
                          ? Colors.redAccent
                          : Colors.greenAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      asset,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  Text(
                    'With',
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Get.theme.hintColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      fiat,
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
              Obx(
                () => Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      decoration: BoxDecoration(
                          color: status.value
                              ? Colors.greenAccent.withOpacity(0.3)
                              : Colors.redAccent.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2)),
                      child: Text(
                        status.value ? 'Online' : 'Offline',
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: status.value ? Colors.green : Colors.redAccent,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CupertinoSwitch(
                      activeColor: Get.theme.accentColor,
                      value: status.value,
                      trackColor: Get.theme.hintColor,
                      onChanged: (value) {
                        //todo: add the callback here for making it online and offline
                        status.value = value;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                fiatCurrency,
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                priceInFiat,
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total amount',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.hintColor,
                ),
              ),
              Text(
                '$totalAmount $asset',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Limit',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.hintColor,
                ),
              ),
              Text(
                '$lowerLimit - $upperLimit $fiat',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Get.theme.textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.primaries[
                            _random.nextInt(Colors.primaries.length)],
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Text(' '),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      bankName,
                      style: TextStyle(
                        fontFamily: "Popins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        color: Get.theme.hintColor,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  //todo: add the onTap here for the widget callback
                  child: Icon(
                    Icons.more_vert,
                    color: Get.theme.textSelectionTheme.selectionColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkAndTake() {
    if (_homeController.user.value.level ==
        _homeController.publicMemberLevel.value.withdraw.minimumLevel) {
      Get.toNamed('/p2p_ad_post_initial_page');
    } else
      Get.toNamed('/p2p_ads_page_level_check_page');
  }
}
