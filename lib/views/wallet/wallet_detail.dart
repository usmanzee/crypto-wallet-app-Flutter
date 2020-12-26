import 'package:crypto_template/controllers/transaction_history_controller.dart';
import 'package:crypto_template/views/wallet/deposit/crypto.dart';
import 'package:crypto_template/views/wallet/deposit/fiat.dart';
import 'package:crypto_template/views/wallet/withdraw/crypto.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:crypto_template/views/wallet/wallet_amount_header.dart';

class WalletDetail extends StatefulWidget {
  final WalletClass.Wallet wallet;
  WalletDetail({Key key, this.wallet}) : super(key: key);

  @override
  _WalletDetailState createState() => _WalletDetailState(wallet: wallet);
}

class _WalletDetailState extends State<WalletDetail> {
  final WalletClass.Wallet wallet;
  _WalletDetailState({this.wallet});
  TransactionHistoryController transactionHistoryController;
  @override
  void initState() {
    transactionHistoryController =
        Get.put(TransactionHistoryController(currency: wallet.currency));
    print('widget init');
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.wallet.name,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
                // height: 500,
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: _cardHeader(context, widget.wallet),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Transactions History",
                              style: TextStyle(
                                  letterSpacing: 1.1, fontFamily: "Sans")),
                          FlatButton(
                            height: 32.0,
                            minWidth: 120.0,
                            textColor: Theme.of(context).accentColor,
                            child: Text(
                              "view All",
                              style: TextStyle(fontSize: 12),
                            ),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10)),
                            splashColor:
                                Theme.of(context).accentColor.withOpacity(0.5),
                          )
                        ],
                      ),
                    ),
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
                                            // labelColor: Theme.of(context).primaryColor,
                                            indicatorColor:
                                                Theme.of(context).primaryColor,
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
                                                      fontFamily: "Sans"),
                                                ),
                                              ),
                                              new Tab(
                                                child: Text(
                                                  "Withdraw History",
                                                  style: TextStyle(
                                                      fontFamily: "Sans"),
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
                                      Obx(() {
                                        if (transactionHistoryController
                                            .isLoading.value)
                                          return Text('Loading..');
                                        else
                                          return Container(
                                              // height: 400.0,
                                              child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            // physics: AlwaysScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(top: 0.0),
                                            itemBuilder: (ctx, i) {
                                              return _card(
                                                  Colors.redAccent
                                                      .withOpacity(0.75),
                                                  "06/03/2018",
                                                  "Confirming",
                                                  "- 0.010",
                                                  "BTC",
                                                  Icons.mobile_screen_share);
                                            },
                                            itemCount:
                                                transactionHistoryController
                                                    .depositHistory.length,
                                          ));
                                      }),
                                      Obx(() {
                                        if (transactionHistoryController
                                            .isLoading.value)
                                          return Text('Loading..');
                                        else
                                          return Container(
                                              // height: 400.0,
                                              child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            // physics: AlwaysScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(top: 0.0),
                                            itemBuilder: (ctx, i) {
                                              return _card(
                                                  Colors.redAccent
                                                      .withOpacity(0.75),
                                                  "06/03/2018",
                                                  "Confirming",
                                                  "- 0.010",
                                                  "BTC",
                                                  Icons.mobile_screen_share);
                                            },
                                            itemCount:
                                                transactionHistoryController
                                                    .withdrawHistory.length,
                                          ));
                                      }),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 180.0,
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
                  SizedBox(
                    width: 0.0,
                  ),
                  Container(
                    height: 40.0,
                    width: 180.0,
                    child: MaterialButton(
                      splashColor: Colors.black12,
                      highlightColor: Colors.black12,
                      color: Colors.redAccent.withOpacity(0.8),
                      onPressed: () {
                        Get.to(WithdrawCrypto(
                          wallet: wallet,
                        ));
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Widget card transaction
  ///
  Widget _card(Color _color, String _time, String _info, String _value,
      String _crypto, IconData _icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 44.0,
                width: 44.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(70.0)),
                  border: Border.all(color: _color),
                ),
                child: Center(
                  child: Icon(
                    _icon,
                    color: _color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _time,
                      style: TextStyle(
                        fontSize: 16.5,
                        letterSpacing: 1.2,
                        fontFamily: "Sans",
                        // color: Colors.white70
                      ),
                    ),
                    Text(_info,
                        style: TextStyle(
                            // color: Colors.white24,
                            letterSpacing: 1.1,
                            fontFamily: "Popins",
                            fontSize: 13.0))
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                _value,
                style: TextStyle(
                    fontSize: 19.5,
                    letterSpacing: 1.6,
                    fontFamily: "Sans",
                    fontWeight: FontWeight.w600,
                    color: _color),
              ),
              Text(_crypto,
                  style: TextStyle(
                      color: Colors.white24,
                      letterSpacing: 1.1,
                      fontFamily: "Popins",
                      fontSize: 13.0))
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// Widget credit card transaction
  ///
  Widget _cardHeader(context, WalletClass.Wallet wallet) {
    return Stack(
      children: <Widget>[
        Container(
          // height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0),
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
                            fontFamily: "Sans",
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0,
                            letterSpacing: 1.5,
                            // color: Colors.white
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
