import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/components/drop_down_menu_widget.dart';
import 'package:b4u_wallet/views/p2p/p2p_buy_sell_tabs/express_buy_sell_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/dialog_widget.dart';

class P2pExpressPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        actions: [
          Container(),
        ],
        titleSpacing: 0,
        toolbarHeight: 96,
        automaticallyImplyLeading: false,
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Get.theme.textSelectionTheme.selectionColor,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return dialogWidget();
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'Express',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  // color: Get.theme.scaffoldBackgroundColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color:
                                    Get.theme.textSelectionTheme.selectionColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed('/select_currency_p2p_page'),
                          child: Row(
                            children: [
                              Align(
                                child: Text(
                                  'UAH',
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    color: _p2pController.buySellOrExpress.value
                                        ? Get.theme.scaffoldBackgroundColor
                                        : Get.theme.textSelectionTheme
                                            .selectionColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 10),
                                child: Icon(
                                  Icons.swap_horiz,
                                  size: 20,
                                  color: _p2pController.buySellOrExpress.value
                                      ? Get.theme.scaffoldBackgroundColor
                                      : Get.theme.textSelectionTheme
                                          .selectionColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        dropDownMenuWidget(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 4,
                  top: 18,
                ),
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _p2pController.buyOrSellExpress.value
                                ? null
                                : () {
                                    _p2pController.buyOrSellExpress.value = true;
                                  },
                            child: Text(
                              'Buy',
                              style: TextStyle(
                                fontFamily: "Popins",
                                color: _p2pController.buyOrSellExpress.value
                                    ? Get
                                        .theme.textSelectionTheme.selectionColor
                                    : Get
                                        .theme.textSelectionTheme.selectionColor
                                        .withOpacity(0.5),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _p2pController.buyOrSellExpress.value
                                ? () {
                                    _p2pController.buyOrSellExpress.value =
                                        false;
                                  }
                                : null,
                            child: Text(
                              'Sell',
                              style: TextStyle(
                                fontFamily: "Popins",
                                color: _p2pController.buyOrSellExpress.value
                                    ? Get
                                        .theme.textSelectionTheme.selectionColor
                                        .withOpacity(0.5)
                                    : Get.theme.textSelectionTheme
                                        .selectionColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/p2p_history_page');
                            },
                            child: Icon(
                              Icons.insert_drive_file_outlined,
                              size: 25,
                              color: Get.theme.textSelectionTheme.selectionColor
                                  .withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 8,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  left: 4,
                ),
                child: TabBar(
                  labelColor: Get.theme.primaryColor,
                  unselectedLabelColor: Get.theme.hintColor,
                  indicator: BoxDecoration(
                    color: Get.theme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  isScrollable: true,
                  tabs: [
                    tab(currencyName: "USDT", currencyFullName: 'Tether'),
                    tab(currencyName: "BTC", currencyFullName: 'Bitcoin'),
                    tab(currencyName: "ETH", currencyFullName: 'Ethereum'),
                    tab(currencyName: "TRST", currencyFullName: 'WeTrust Coin'),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => TabBarView(
                    children: [
                      expressBuySellTabWidget(
                        currencyName: 'USDT',
                        transfer: _p2pController.buyOrSellExpress.value,
                        buyingCurrency: 'Rs',
                        hintFirstText: _p2pController.buyOrSellExpress.value
                            ? 'Above'
                            : 'Available',
                        hintSecondText: _p2pController.buyOrSellExpress.value
                            ? '20'
                            : '200000',
                        referencePrice: 159.00.toString(),
                      ),
                      expressBuySellTabWidget(
                        currencyName: 'BTC',
                        transfer: _p2pController.buyOrSellExpress.value,
                        buyingCurrency: 'Rs',
                        hintFirstText: _p2pController.buyOrSellExpress.value
                            ? 'Above'
                            : 'Available',
                        hintSecondText: _p2pController.buyOrSellExpress.value
                            ? '20'
                            : '200000',
                        referencePrice: 159.00.toString(),
                      ),
                      expressBuySellTabWidget(
                        currencyName: 'ETH',
                        transfer: _p2pController.buyOrSellExpress.value,
                        buyingCurrency: 'Rs',
                        hintFirstText: _p2pController.buyOrSellExpress.value
                            ? 'Above'
                            : 'Available',
                        hintSecondText: _p2pController.buyOrSellExpress.value
                            ? '20'
                            : '200000',
                        referencePrice: 159.00.toString(),
                      ),
                      expressBuySellTabWidget(
                        currencyName: 'TRST',
                        transfer: _p2pController.buyOrSellExpress.value,
                        buyingCurrency: 'Rs',
                        hintFirstText: _p2pController.buyOrSellExpress.value
                            ? 'Above'
                            : 'Available',
                        hintSecondText: _p2pController.buyOrSellExpress.value
                            ? '20'
                            : '200000',
                        referencePrice: 159.00.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tab({String currencyName, String currencyFullName}) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currencyName.toUpperCase(),
              style: TextStyle(
                fontFamily: "Popins",
                // color: Get.theme.primaryColor,
                fontSize: 16.0,
                height: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              currencyFullName,
              style: TextStyle(
                fontFamily: "Popins",
                color: Get.theme.hintColor,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
