import 'package:crypto_template/controllers/crypto_deposit_controller.dart';
import 'package:crypto_template/views/wallet/custom_appbar.dart';
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
        child: WalletCustomAppbar(
          title: 'Deposit',
          screenType: 'deposit',
          wallet: wallet,
        ),
      ),
      body: SingleChildScrollView(
        child: wallet.depositEnabled
            ? Column(children: [
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
                                              color:
                                                  Theme.of(context).hintColor),
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
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '* Sending coin or token other than ' +
                                          wallet.currency.toUpperCase() +
                                          ' to this address may result in the loss of your deposit.',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      '* Until 6 confirmations are made, an equivalent amount of your assets will be temporarily unavailable for withdrawals.',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
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
              ])
            : _depositDisabled(context),
      ),
    );
  }

  Widget _depositDisabled(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
