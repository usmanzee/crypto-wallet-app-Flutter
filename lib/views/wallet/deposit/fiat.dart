import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/fiat_deposit_controller.dart';
import 'package:crypto_template/views/wallet/search_wallet_header.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:crypto_template/utils/Helpers/helper.dart';

class DepositFiat extends StatefulWidget {
  final WalletClass.Wallet wallet;
  DepositFiat({Key key, this.wallet}) : super(key: key);

  @override
  _DepositFiatState createState() => _DepositFiatState(wallet: wallet);
}

class _DepositFiatState extends State<DepositFiat> {
  final WalletClass.Wallet wallet;
  _DepositFiatState({this.wallet});
  FiatDepositController depositController;
  HomeController homeController = Get.find();

  var depositDetails;
  var loading = true;

  Future<void> getDepositDetails() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await get(
          'https://ewallet.b4uwallet.com/public_data/bank_details.json');
      var data = jsonDecode(response.body);
      // print(data);
      setState(() {
        depositDetails = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print('caught error: $e');
    }
  }

  _copyToClipboard(String text) {
    Helper.copyToClipBoard(text);
  }

  @override
  void initState() {
    depositController =
        Get.put(FiatDepositController(currency: wallet.currency));
    getDepositDetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'fiat_deposit.screen.title'.tr,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1.0,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Column(children: [
        SearchHeader(
          screenType: 'deposit',
          wallet: wallet,
        ),
        wallet.depositEnabled
            ? Flexible(
                child: Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('fiat_deposit.screen.sub_title'.tr,
                                  style: TextStyle(
                                      fontSize: 18.5,
                                      fontFamily: 'Popins',
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('fiat_deposit.screen.desc'.tr,
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      fontFamily: 'Popins',
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 8.0,
                                    bottom: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.9)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.emoji_objects,
                                                  size: 15.0,
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Text(
                                                      'fiat_deposit.screen.reference_code.instruction'
                                                          .tr
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .errorColor,
                                                        fontSize: 10,
                                                        fontFamily: "Popins",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "fiat_deposit.screen.reference_code"
                                                    .tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.5),
                                                    fontFamily: "Popins",
                                                    fontSize: 15.5),
                                              ),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Text(
                                                homeController.user.value.uid,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textSelectionColor,
                                                    fontFamily: "Popins",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.5),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                width: 30.0,
                                                child: IconButton(
                                                  icon:
                                                      Icon(Icons.content_copy),
                                                  tooltip: 'Copy Referance Id',
                                                  onPressed: () {
                                                    _copyToClipboard(
                                                        homeController
                                                            .user.value.uid);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (loading)
                          Container(
                              width: double.infinity,
                              height: 200,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                        else
                          Column(
                            children:
                                depositDetails.map<Widget>((depositDetail) {
                              if (depositDetail['title'] == wallet.currency) {
                                return Container(
                                  height: 650.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: DefaultTabController(
                                          length: depositDetail['banks'].length,
                                          child: Scaffold(
                                            appBar: PreferredSize(
                                              preferredSize: Size.fromHeight(
                                                  40.0), // here the desired height
                                              child: AppBar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .canvasColor,
                                                elevation: 2,
                                                centerTitle: true,
                                                flexibleSpace: SafeArea(
                                                  child: Container(
                                                    child: new TabBar(
                                                      indicator:
                                                          UnderlineTabIndicator(
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 2,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                              insets: EdgeInsets
                                                                  .only(
                                                                      left: -8,
                                                                      right: 8,
                                                                      bottom:
                                                                          0)),
                                                      isScrollable: true,
                                                      labelPadding:
                                                          EdgeInsets.only(
                                                              left: 8,
                                                              right: 16),
                                                      labelColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      unselectedLabelColor: Theme
                                                              .of(context)
                                                          .textSelectionColor,
                                                      indicatorSize:
                                                          TabBarIndicatorSize
                                                              .label,
                                                      tabs:
                                                          depositDetail['banks']
                                                              .map<Widget>(
                                                                  (bank) {
                                                        var index =
                                                            depositDetail[
                                                                        'banks']
                                                                    .indexOf(
                                                                        bank) +
                                                                1;
                                                        return Tab(
                                                          child: Text(
                                                              'fiat_deposit.screen.bank'
                                                                      .tr +
                                                                  ' $index',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textSelectionColor,
                                                                  fontFamily:
                                                                      "Popins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14.5)),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                                automaticallyImplyLeading:
                                                    false,
                                              ),
                                            ),
                                            body: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new TabBarView(
                                                children: depositDetail['banks']
                                                    .map<Widget>((bank) {
                                                  return Column(
                                                      children: bank.keys
                                                          .map<Widget>((item) {
                                                    return Card(
                                                      child: ListTile(
                                                        title: Text(
                                                            item.toString(),
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textSelectionColor,
                                                                fontFamily:
                                                                    "Popins",
                                                                fontSize:
                                                                    15.5)),
                                                        subtitle: Text(
                                                            bank[item]
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .hintColor
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontFamily:
                                                                    "Popins",
                                                                fontSize:
                                                                    13.5)),
                                                        trailing: Container(
                                                          width: 30.0,
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: IconButton(
                                                            icon: Icon(
                                                                Icons
                                                                    .content_copy,
                                                                size: 20.0,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textSelectionColor),
                                                            onPressed: () {
                                                              _copyToClipboard(
                                                                  bank[item]
                                                                      .toString());
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList());
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                      ],
                    )),
              )
            : _depositDisabled(context),
      ]),
    );
  }
}

Widget _depositDisabled(context) {
  return Container(
    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
    width: double.infinity,
    child: Column(children: <Widget>[
      SizedBox(
        height: 16.0,
      ),
      Icon(
        Icons.lock,
        color: Theme.of(context).primaryColor,
        size: 72.0,
        semanticLabel: 'disabled',
      ),
      SizedBox(
        height: 16.0,
      ),
      Center(
        child: Text(
          'Deposit is disabled by the administration',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
    ]),
  );
}

const bankCurrencies = [
  {
    "id": '1',
    "title": 'eur',
    "banks": [
      {
        "Bank Name": 'TransferWise',
        "Account holder": 'B4U Group of Companies, S.L',
        "IBAN": 'BE79 9670 5851 7133',
        "SWIFT/BIC": 'TRWIBEB1XXX',
        "Address":
            'TransferWise Europe SA \nAvenue Louise 54, Room S52\n Brussels\n 1050\n Belgium',
      },
      {
        "Bank Name": 'TransferWise1',
        "Account holder": 'B4U Group of Companies, S.L',
        "IBAN": 'BE79 9670 5851 7133',
        "SWIFT/BIC": 'TRWIBEB1XXX',
        "Address":
            'TransferWise Europe SA \nAvenue Louise 54, Room S52\n Brussels\n 1050\n Belgium',
      }
    ]
  },
  {
    "id": '2',
    "title": 'myr',
    "banks": [
      {
        "Bank Name": 'OCBC Bank',
        "Account holder": 'BRAVO Tech Trading',
        "Account Number": '704-128-334-9',
      }
    ]
  },
  {
    "id": '3',
    "title": 'usd',
    "banks": [
      {
        "Bank Name": 'TransferWise',
        "Account holder": 'B4U Group of Companies, S.L.',
        "ACH routing number": '026073150',
        "Wire routing number": '026073008',
        "Account number": '8310615550',
        "Account type": 'Checking',
        "Address":
            'TransferWise 19 W 24th Street \nNew York NY 10010\n United States',
      }
    ]
  },
  {
    "id": '4',
    "title": 'sgd',
    "banks": [
      {
        "Account holder": 'BRAVO Tech Trading',
        "Bank Name": 'OCBC Bank',
        "Account Number": '704-128-335-7',
      }
    ]
  }
];
