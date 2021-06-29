import 'package:b4u_wallet/controllers/transfer_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/transfer/currency_selection_page.dart';
import 'package:b4u_wallet/views/transfer/wallets_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  void initState() {
    currencyName = walletController.walletsList.length ==0 ? '' : walletController.walletsList[0].currency;
    currencyTotal = walletController.walletsList.length ==0 ? '' : walletController.walletsList[0].currency;
    super.initState();
  }

  final _transferController = Get.put(TransferController());
  final WalletController walletController = Get.find<WalletController>();
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool swap = false;
  final String spotName = 'Spot';
  String walletName = 'p2p';
  String currencyName = 'btc';
  String currencyTotal = '0.000000';
  String currencyImage = MyImgs.testPhoto;
  IconData walletIcon = Icons.people;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.history,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.canvasColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                swap ? Icons.scatter_plot_outlined : walletIcon,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('From'),
                              SizedBox(
                                width: 20,
                              ),
                              swap
                                  ? Text(
                                      '$spotName Wallet',
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : _walletType(
                                      walletName: walletName,
                                      callback: () => Get.to(
                                          () => WalletsList(walletCallback))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 5),
                            child: Icon(
                              Icons.arrow_downward,
                              size: 15,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                swap ? walletIcon : Icons.scatter_plot_outlined,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('To    '),
                              SizedBox(
                                width: 20,
                              ),
                              swap
                                  ? _walletType(
                                      walletName: walletName,
                                      callback: () => Get.to(
                                          () => WalletsList(walletCallback)))
                                  : Text(
                                      '$spotName Wallet',
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                              // _walletType(walletName: 'P2P Wallet'),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          swap = !swap;
                          setState(() {
                            print(swap);
                          });
                        },
                        child: Icon(
                          Icons.swap_vert,
                          size: 40,
                          color: Get.theme.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(CurrencySelection(currencyCallback));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Get.theme.canvasColor,
                      ),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                currencyImage,
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  currencyName.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    color: Get.theme.textSelectionTheme
                                        .selectionColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Get.theme.accentColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: Get.theme.textSelectionTheme.selectionColor
                          .withOpacity(0.4),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.canvasColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          onChanged: (string) {
                            setState(() {});
                          },
                          controller: _textController,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.number,
                          maxLength: 20,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 5, right: 5),
                            border: InputBorder.none,
                            counterText: '',
                            suffix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _textController.value.text == ''
                                    ? Container()
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Get.theme.accentColor
                                              .withOpacity(0.8),
                                        ),
                                        padding: const EdgeInsets.all(1),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _textController.clear();
                                              _focusNode.unfocus();
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 15,
                                            color: Get
                                                .theme.scaffoldBackgroundColor,
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 8.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        //flex: 2,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              currencyName.toUpperCase(),
                              style: TextStyle(
                                fontFamily: "Popins",
                                color: Get
                                    .theme.textSelectionTheme.selectionColor
                                    .withOpacity(0.4),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                //click for adding the whole value to the textcontroller.
                                setState(() {
                                  _textController.text = currencyTotal;
                                  _focusNode.requestFocus();
                                });
                              },
                              child: Text(
                                'MAX',
                                style: TextStyle(
                                  fontFamily: "Popins",
                                  color: Get.theme.accentColor.withOpacity(0.4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Available Balance $currencyTotal ${currencyName.toUpperCase()}',
                  style: TextStyle(
                    fontFamily: "Popins",
                    color: Get.theme.textSelectionTheme.selectionColor
                        .withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: walletController.walletsList.length == 0 ? null : () async{
                showDialog(context: context, builder: (context) {
                  return Center(child: CircularProgressIndicator(),);
                },);
                final res = await _transferController.transferAsset(
                  amount: _textController.value.text,
                  currencyCode: currencyName,
                  sourceWallet: swap ? spotName.toLowerCase() : walletName.toLowerCase(),
                  targetWallet: swap ? walletName.toLowerCase() : spotName.toLowerCase(),
                );
                if(res){
                  Get.back();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Amount Transferred'),));
                }else{
                  Get.back();
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: walletController.walletsList.length == 0 ? Get.theme.canvasColor : Get.theme.accentColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    'Transfer',
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: walletController.walletsList.length == 0 ? Get.theme.textSelectionTheme.selectionColor : Get.theme.scaffoldBackgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _walletType({
    @required String walletName,
    Function callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        children: [
          Text(
            '${walletName.toUpperCase()} Wallet',
            style: TextStyle(
              fontFamily: "Popins",
              color: Get.theme.textSelectionTheme.selectionColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: 20,
          ),
        ],
      ),
    );
  }

//callback for fetching the values from the currency list screen
  void currencyCallback({String name, String icon, String total}) {
    setState(() {
      currencyImage = icon;
      currencyName = name;
      currencyTotal = total;
    });
    if (currencyImage == null) {
      currencyImage = MyImgs.testPhoto;
    }
    print(currencyName);
  }

//callback for fetching the wallet type from the wallet list.
  void walletCallback({String name, IconData icon}) {
    setState(() {
      walletName = name;
      walletIcon = icon;
    });
  }
}
