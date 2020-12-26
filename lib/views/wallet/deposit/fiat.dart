import 'package:crypto_template/controllers/fiat_deposit_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    depositController =
        Get.put(FiatDepositController(currency: wallet.currency));
    print('widget init');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: AppBar(
          title: Text(
            'Deposit',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          centerTitle: true,
          flexibleSpace: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: wallet.iconUrl != null
                                    ? Image.network(
                                        wallet.iconUrl,
                                        height: 25.0,
                                        fit: BoxFit.contain,
                                        width: 25.0,
                                      )
                                    : Image.asset(
                                        'assets/image/market/BCH.png',
                                        height: 25.0,
                                        fit: BoxFit.contain,
                                        width: 25.0,
                                      ),
                              ),
                              Text(
                                wallet.currency.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0,
                                  letterSpacing: 1.5,
                                  // color: Colors.white
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ))
                  ])),
          iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
          elevation: 1.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Deposit using bank transfer',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                      'Please use the following credentials to initiate your bank transfer. Your deposit will be reflected in your account in minimum 2 hours.',
                      style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.9)),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.emoji_objects,
                                      size: 15.0,
                                      color: Theme.of(context).errorColor,
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'PLEASE USE THE BELOW REFERENCE CODE IN YOUR PAYMENT REFERENCE.',
                                          style: TextStyle(
                                            color: Theme.of(context).errorColor,
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
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Reference code",
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
                                    'ID0D2741FBCA',
                                    style: TextStyle(fontFamily: "Popins"),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(0.0),
                                    width: 30.0,
                                    child: IconButton(
                                      icon: Icon(Icons.content_copy),
                                      tooltip: 'Copy Referance Id',
                                      onPressed: () {
                                        Clipboard.setData(new ClipboardData(
                                                text: 'ID0D2741FBCA'))
                                            .then((value) {
                                          Get.snackbar(
                                              'Success', 'Copied to clipboard',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText: Colors.white,
                                              backgroundColor:
                                                  Colors.grey[900]);
                                        });
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
            SizedBox(
              height: 8.0,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                // borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text('Bank Details',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Bank Name'),
                      subtitle: Text('TransferWise'),
                      trailing: Icon(Icons.content_copy),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Account Holder'),
                      subtitle: Text('B4U Group of Companies, S.L.'),
                      trailing: Icon(Icons.content_copy),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Ach Routing Number'),
                      subtitle: Text('026073150'),
                      trailing: Icon(Icons.content_copy),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Address'),
                      subtitle: Text(
                          'TransferWise 19 W 24th Street New York NY 10010 United States'),
                      trailing: Icon(Icons.content_copy),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
