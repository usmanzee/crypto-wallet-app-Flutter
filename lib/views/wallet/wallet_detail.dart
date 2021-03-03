import 'package:crypto_template/controllers/transaction_history_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:crypto_template/views/wallet/deposit/crypto.dart';
import 'package:crypto_template/views/wallet/deposit/fiat.dart';
import 'package:crypto_template/views/wallet/history/deposit_history_list.dart';
import 'package:crypto_template/views/wallet/history/withdraw_history_list.dart';
import 'package:crypto_template/views/wallet/withdraw/crypto.dart';
import 'package:crypto_template/views/wallet/withdraw/fiat.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:crypto_template/views/wallet/wallet_amount_header.dart';
import 'package:flutter/services.dart';

class WalletDetail extends StatelessWidget {
  final WalletClass.Wallet wallet;
  final WalletController walletController = Get.find<WalletController>();
  final TransactionHistoryController transactionHistoryController;
  WalletDetail({Key key, this.wallet})
      : transactionHistoryController =
            Get.put(TransactionHistoryController(currency: wallet.currency));

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          wallet.name,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1.0,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: ListView(
                  children: <Widget>[
                    _cardHeader(context, wallet),
                    Container(
                      height: 470.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: DefaultTabController(
                              length: 2,
                              child: Scaffold(
                                appBar: PreferredSize(
                                  preferredSize: Size.fromHeight(
                                      40.0), // here the desired height
                                  child: AppBar(
                                    backgroundColor:
                                        Theme.of(context).canvasColor,
                                    elevation: 2,
                                    centerTitle: true,
                                    flexibleSpace: SafeArea(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 50.0),
                                          child: new TabBar(
                                            indicator: UnderlineTabIndicator(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                insets: EdgeInsets.only(
                                                    left: -8,
                                                    right: 8,
                                                    bottom: 0)),
                                            isScrollable: true,
                                            labelPadding: EdgeInsets.only(
                                                left: 0, right: 16),
                                            labelColor:
                                                Theme.of(context).primaryColor,
                                            unselectedLabelColor:
                                                Theme.of(context)
                                                    .textSelectionColor,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            tabs: [
                                              new Tab(
                                                child: Text(
                                                  "Deposit History",
                                                  style: TextStyle(
                                                      fontFamily: "Popins"),
                                                ),
                                              ),
                                              new Tab(
                                                child: Text(
                                                  "Withdraw History",
                                                  style: TextStyle(
                                                      fontFamily: "Popins"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    automaticallyImplyLeading: false,
                                  ),
                                ),
                                body: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
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
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40.0,
                    child: MaterialButton(
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      color: Color(0xFF2ebd85),
                      onPressed: () {
                        if (wallet.type == 'coin') {
                          Get.to(DepositCrypto(wallet: wallet));
                        } else {
                          Get.to(DepositFiat(wallet: wallet));
                        }
                      },
                      child: Center(
                          child: Text(
                        "Deposit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                            fontSize: 16.0),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    height: 40.0,
                    child: MaterialButton(
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      color: Colors.redAccent.withOpacity(0.8),
                      onPressed: () {
                        if (wallet.type == 'coin') {
                          Get.to(WithdrawCrypto(wallet: wallet));
                        } else {
                          Get.to(WithdrawFiat(wallet: wallet));
                        }
                      },
                      child: Center(
                          child: Text(
                        "Withdraw",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Popins",
                            letterSpacing: 1.3,
                            fontSize: 16.0),
                      )),
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
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: wallet.iconUrl != null
                            ? Image.network(
                                wallet.iconUrl,
                                height: 35.0,
                                fit: BoxFit.contain,
                                width: 35.0,
                              )
                            : Image.asset(
                                'assets/image/market/BCH.png',
                                height: 35.0,
                                fit: BoxFit.contain,
                                width: 35.0,
                              ),
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
