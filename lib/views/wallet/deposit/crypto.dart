import 'package:crypto_template/controllers/crypto_deposit_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class DepositCrypto extends StatefulWidget {
  final WalletClass.Wallet wallet;
  DepositCrypto({Key key, this.wallet}) : super(key: key);

  @override
  _WalletState createState() => _WalletState(wallet: wallet);
}

class _WalletState extends State<DepositCrypto> {
  final WalletClass.Wallet wallet;
  _WalletState({this.wallet});
  CryptoDepositController depositController;

  share(BuildContext context) {
    final _shareAddress = wallet.currency == 'xrp'
        ? depositController.depositAddress.value +
            '?dt=' +
            depositController.depositTag.value
        : depositController.depositAddress.value;
    final RenderBox box = context.findRenderObject();
    Share.share(
        wallet.name +
            ' Address: ' +
            _shareAddress +
            "\n\nhttps://ewallet.b4uwallet.com/",
        subject: 'B4U Wallet',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    depositController =
        Get.put(CryptoDepositController(currency: wallet.currency));
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
        child: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Obx(() {
                  if (depositController.isAddressLoading.value) {
                    return _loadingAddressAnimation(context);
                  } else {
                    if (depositController.depositAddress.value == '')
                      return _addressNotFound(context);
                    else
                      return Column(
                        children: [
                          (depositController.depositTag.value != '')
                              ? Column(children: [
                                  _showTagDepositInstruction(context),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                ])
                              : Container(),
                          Column(children: [
                            _showAddress(context),
                            Container(
                              width: double.infinity,
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                          ]),
                          (depositController.depositTag.value != '')
                              ? Column(children: [
                                  _showTag(context),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                ])
                              : Container(),
                          _showQRCode(context),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Send only ' +
                                    wallet.currency.toUpperCase() +
                                    ' to this deposit address',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '* Sending coin or token other than ' +
                                    wallet.currency.toUpperCase() +
                                    ' to this address may result in the loss of your deposit.',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '* Until 6 confirmations are made, an equivalent amount of your assets will be temporarily unavailable for withdrawals.',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          )
                        ],
                      );
                  }
                }),
                SizedBox(
                  height: 16.0,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _loadingAddressAnimation(context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _addressNotFound(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: 40.0,
          width: 150.0,
          color: Theme.of(context).primaryColor,
          child: GestureDetector(
            onTap: () {
              depositController.fetchDepositAddress(wallet.currency);
            },
            child: Center(
              child: Text(
                "Generate Address",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
      ]),
    );
  }

  Widget _showAddress(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(wallet.currency.toUpperCase() + ' Address'),
              Spacer(flex: 1),
              FlatButton(
                height: 30.0,
                minWidth: 40.0,
                color: Theme.of(context).canvasColor,
                // textColor: Colors.white,
                child: Text(
                  "Copy Address",
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                          text: depositController.depositAddress.value))
                      .then((value) {
                    Get.snackbar('Success', 'Copied to clipboard',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: Colors.grey[900]);
                  });
                },
                splashColor: Theme.of(context).canvasColor.withOpacity(0.5),
              )
            ],
          ),
          Text(
            depositController.depositAddress.value,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).hintColor.withOpacity(0.6),
              fontSize: 12,
              fontFamily: "Popins",
            ),
          ),
        ],
      ),
    );
  }

  Widget _showQRCode(context) {
    return Column(children: [
      QrImage(
          data: depositController.depositAddress.value,
          version: QrVersions.auto,
          size: 160.0,
          backgroundColor: Colors.white),
      SizedBox(
        height: 16.0,
      ),
      FlatButton(
        height: 40.0,
        minWidth: 150.0,
        color: Theme.of(context).canvasColor,
        // textColor: Colors.white,
        child: new Text("Share"),
        onPressed: () {
          share(context);
        },
        splashColor: Theme.of(context).canvasColor.withOpacity(0.5),
      )
    ]);
  }

  Widget _showTagDepositInstruction(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Theme.of(context).canvasColor,
        color: Theme.of(context).errorColor.withOpacity(0.3),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Icon(
          Icons.emoji_objects,
          size: 15.0,
          color: Theme.of(context).errorColor,
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Please enter both Tag and Address data, which are required to deposit ' +
                  wallet.currency.toUpperCase() +
                  ' to your B4U account successfully.',
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontSize: 10,
                fontFamily: "Popins",
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _showTag(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(wallet.currency.toUpperCase() + ' Tag'),
              Spacer(flex: 1),
              FlatButton(
                height: 30.0,
                minWidth: 40.0,
                color: Theme.of(context).canvasColor,
                // textColor: Colors.white,
                child: new Text(
                  "Copy Tag",
                  style: TextStyle(fontSize: 10),
                ),
                onPressed: () {
                  Clipboard.setData(new ClipboardData(
                          text: depositController.depositTag.value))
                      .then((value) {
                    Get.snackbar('Success', 'Copied to clipboard',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: Colors.grey[900]);
                  });
                },
                splashColor: Colors.redAccent,
              )
            ],
          ),
          Text(
            depositController.depositTag.value,
            style: TextStyle(
              color: Theme.of(context).hintColor.withOpacity(0.7),
              fontFamily: "Popins",
            ),
          ),
        ],
      ),
    );
  }
}
