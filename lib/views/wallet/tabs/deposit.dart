import 'package:crypto_template/controllers/deposit_controller.dart';
import 'package:crypto_template/screen/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class Deposit extends StatefulWidget {
  final WalletClass.Wallet wallet;

  Deposit({this.wallet});

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  DepositController depositController;
  @override
  void initState() {
    depositController =
        Get.put(DepositController(currency: widget.wallet.currency));
    super.initState();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            // height: 140.0,
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      (double.parse(widget.wallet.balance) +
                              double.parse(widget.wallet.locked))
                          .toStringAsFixed(widget.wallet.precision),
                      style: TextStyle(fontFamily: "Popins"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Available",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      widget.wallet.balance,
                      style: TextStyle(fontFamily: "Popins"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Locked",
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.5),
                          fontFamily: "Popins",
                          fontSize: 15.5),
                    ),
                    Text(
                      widget.wallet.locked,
                      style: TextStyle(
                        fontFamily: "Popins",
                        color: Theme.of(context).hintColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Obx(() {
            if (depositController.isAddressLoading.value) {
              return _loadingAddressAnimation();
            } else {
              if (depositController.depositAddress.value == '')
                return _addressNotFound();
              else
                return Column(
                  children: [
                    (depositController.depositTag.value != '')
                        ? Column(children: [
                            _showTagDepositInstruction(),
                            SizedBox(
                              height: 8.0,
                            ),
                          ])
                        : Container(),
                    Column(children: [
                      _showAddress(),
                      SizedBox(
                        height: 8.0,
                      ),
                    ]),
                    (depositController.depositTag.value != '')
                        ? Column(children: [
                            _showTag(),
                            SizedBox(
                              height: 8.0,
                            ),
                          ])
                        : Container(),
                    _showQRCode()
                  ],
                );
            }
          }),
          SizedBox(
            height: 8.0,
          )
        ],
      ),
    );
  }

  Widget _loadingAddressAnimation() {
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

  Widget _addressNotFound() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
              depositController.fetchDepositAddress(widget.wallet.balance);
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

  Widget _showAddress() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(widget.wallet.currency.toUpperCase() + ' Address'),
              Spacer(flex: 1),
              FlatButton(
                height: 30.0,
                minWidth: 40.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
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
                splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
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

  Widget _showQRCode() {
    return Column(children: [
      QrImage(
          data: depositController.depositAddress.value,
          version: QrVersions.auto,
          size: 160.0,
          backgroundColor: Colors.white),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        height: 40.0,
        minWidth: 150.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text("Share"),
        onPressed: () {
          Clipboard.setData(new ClipboardData(
                  text: depositController.depositAddress.value))
              .then((value) {
            Get.snackbar('Success', 'Copied to clipboard',
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.grey[900]);
          });
        },
        splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
      )
    ]);
  }

  Widget _showTagDepositInstruction() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Theme.of(context).canvasColor,
          color: Theme.of(context).errorColor.withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                  widget.wallet.currency.toUpperCase() +
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

  Widget _showTag() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      // height: 125.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(widget.wallet.currency.toUpperCase() + ' Tag'),
              Spacer(flex: 1),
              FlatButton(
                height: 30.0,
                minWidth: 40.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
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

  @override
  void dispose() {
    super.dispose();
  }
}
