import 'package:b4u_wallet/models/wallet.dart' as WalletClass;
import 'package:b4u_wallet/views/wallet/deposit/crypto.dart';
import 'package:b4u_wallet/views/wallet/deposit/fiat.dart';
import 'package:b4u_wallet/views/wallet/history/deposit_history_list.dart';
import 'package:b4u_wallet/views/wallet/history/withdraw_history_list.dart';
import 'package:b4u_wallet/views/wallet/wallet_amount_header.dart';
import 'package:b4u_wallet/views/wallet/withdraw/crypto.dart';
import 'package:b4u_wallet/views/wallet/withdraw/fiat.dart';
import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletDetail extends StatelessWidget {
  final WalletClass.Wallet wallet = Get.arguments['wallet'];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          wallet.name,
          style: TextStyle(
            color: Get.theme.textSelectionTheme.selectionColor,
            fontFamily: "Gotik",
            fontWeight: FontWeight.w600,
            fontSize: 18.5,
          ),
        ),
        iconTheme:
            IconThemeData(color: Get.theme.textSelectionTheme.selectionColor),
        elevation: 1.0,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Get.theme.canvasColor,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: _cardHeader(context, wallet)),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: PreferredSize(
                            preferredSize: Size.fromHeight(40.0),
                            child: AppBar(
                              backgroundColor:
                                  Get.theme.scaffoldBackgroundColor,
                              elevation: 0,
                              centerTitle: true,
                              bottom: PreferredSize(
                                  child: Container(
                                    color: Get.theme.canvasColor,
                                    height: 2.0,
                                  ),
                                  preferredSize: Size.fromHeight(4.0)),
                              flexibleSpace: SafeArea(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: new TabBar(
                                      indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                            width: 4,
                                            color: Get.theme.primaryColor,
                                          ),
                                          insets: EdgeInsets.only(
                                              left: -8, right: 8, bottom: 0)),
                                      isScrollable: true,
                                      labelPadding:
                                          EdgeInsets.only(left: 0, right: 16),
                                      labelColor: Get.theme.primaryColor,
                                      unselectedLabelColor: Get.theme
                                          .textSelectionTheme.selectionColor,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      tabs: [
                                        new Tab(
                                          child: Text(
                                            "wallet_detail.screen.p2p_buy_sell_tabs.deposit_history"
                                                .tr,
                                            style: TextStyle(
                                              fontFamily: "Popins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        new Tab(
                                          child: Text(
                                            "wallet_detail.screen.p2p_buy_sell_tabs.withdraw_history"
                                                .tr,
                                            style: TextStyle(
                                                fontFamily: "Popins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              automaticallyImplyLeading: false,
                              actions: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/history');
                                  },
                                  child: Icon(
                                    Icons.history_edu,
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          body: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: new TabBarView(
                              children: [
                                DepositHistoryList(
                                  wallet: wallet,
                                ),
                                WithdrawHistoryList(
                                  wallet: wallet,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            color: Get.theme.canvasColor,
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    splashColor: Colors.black12,
                    highlightColor: Colors.black12,
                    color: Color(0xFF2ebd85),
                    onPressed: () {
                      if (wallet.type == 'coin') {
                        Get.to(() => DepositCrypto(wallet: wallet));
                      } else {
                        Get.to(() => DepositFiat(wallet: wallet));
                      }
                    },
                    child: Center(
                        child: Text(
                      "wallet_detail.screen.button.deposit".tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Popins",
                          letterSpacing: 1.3,
                          fontSize: 16.0),
                    )),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: MaterialButton(
                    splashColor: Colors.black12,
                    highlightColor: Colors.black12,
                    color: Colors.redAccent.withOpacity(0.8),
                    onPressed: () {
                      if (wallet.type == 'coin') {
                        Get.to(() => WithdrawCrypto(wallet: wallet));
                        // Get.toNamed('/withdrawl-crypto',
                        //     arguments: {'wallet': wallet});
                      } else {
                        Get.to(() => WithdrawFiat(wallet: wallet));
                      }
                    },
                    child: Center(
                      child: Text(
                        "wallet_detail.screen.button.withdraw".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cardHeader(context, WalletClass.Wallet wallet) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child:
                            iconWidget(name: wallet.name, url: wallet.iconUrl),
                      ),
                      Text(
                        wallet.currency.toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w800,
                          fontSize: 30.0,
                          letterSpacing: 1.5,
                        ),
                      )
                    ],
                  ),
                  WalletAmountHeader(
                    wallet: wallet,
                  )
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 120.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200.0),
                    topRight: Radius.circular(20.0))),
          ),
        ),
      ],
    );
  }
}
