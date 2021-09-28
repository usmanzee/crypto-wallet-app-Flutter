// import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page/offer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pAdsPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  // final _homeController = Get.find<HomeController>();
  final RxString _selectedElement = ''.obs;

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
          Obx(
            () => _p2pController.userAddedP2pOffers.length == 0
                ? _emptyWidget()
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: _p2pController.userAddedP2pOffers.length,
                        itemBuilder: (context, index) => OfferWidget(
                          index: index,
                          type: _p2pController.userAddedP2pOffers[index].side,
                          asset: _p2pController
                              .userAddedP2pOffers[index].quoteUnit,
                          fiat:
                              _p2pController.userAddedP2pOffers[index].baseUnit,
                          status:
                              _p2pController.userAddedP2pOffers[index].state,
                          //todo: add the currency unit here
                          fiatCurrency:
                              _p2pController.userAddedP2pOffers[index].baseUnit,
                          priceInFiat:
                              _p2pController.userAddedP2pOffers[index].price,
                          totalAmount: _p2pController
                              .userAddedP2pOffers[index].originAmount,
                          lowerLimit: _p2pController
                              .userAddedP2pOffers[index].minOrderAmount,
                          upperLimit: _p2pController
                              .userAddedP2pOffers[index].maxOrderAmount,
                          //todo: add the banks lis here
                          bankName: 'Easypaisa-PK Only',
                        ),
                      ),
                    ),
                  ),
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

  void checkAndTake() {
    /*if (_homeController.user.value.level ==
        _homeController.publicMemberLevel.value.withdraw.minimumLevel) {
      Get.toNamed('/p2p_ad_post_initial_page');
    } else
      Get.toNamed('/p2p_ads_page_level_check_page');*/
    Get.toNamed('/p2p_ad_post_initial_page');
  }

  Widget _emptyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
