import 'package:crypto_template/controllers/fiat_deposit_controller.dart';
import 'package:crypto_template/models/fiat_deposit_details.dart';
import 'package:crypto_template/views/wallet/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';

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

  var depositDetails;

  Future<void> getDepositDetails() async {
    try {
      var response =
          await get('http://10.121.121.113:3000/public_data/bank_details.json');
      var data = jsonDecode(response.body);
      print(data);
      setState(() {
        depositDetails = data;
      });
    } catch (e) {
      print('caught error: $e');
    }
  }

  _copyToClipboard(String text) {
    Clipboard.setData(new ClipboardData(text: text)).then((value) {
      Get.snackbar('Success', 'Copied to clipboard',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
    });
  }

  @override
  void initState() {
    depositController =
        Get.put(FiatDepositController(currency: wallet.currency));
    getDepositDetails();
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
                                        _copyToClipboard('ID0D2741FBCA');
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

                  Column(
                    // padding: EdgeInsets.all(12.0),
                    children: depositDetails.map<Widget>((depositDetail) {
                      if (depositDetail['title'] == wallet.currency) {
                        return Column(
                          children: depositDetail['banks'].map<Widget>((bank) {
                            print(bank);
                            return Text('abc');
                            // return Card(
                            //   child: ListTile(
                            //     title: Text('Bank Name'),
                            //     subtitle: Text('TransferWise'),
                            //     trailing: Container(
                            //       width: 30.0,
                            //       padding: EdgeInsets.all(0),
                            //       child: IconButton(
                            //         icon: Icon(
                            //           Icons.content_copy,
                            //           size: 20.0,
                            //           color: Colors.brown[900],
                            //         ),
                            //         onPressed: () {
                            //           _copyToClipboard('TransferWise');
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // );
                          }).toList(),
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  ),

                  // Obx(() {
                  //   if (depositController.isDepositDetailLoading.value) {
                  //     return Text('Loading...');
                  //   } else {
                  //     return Column(
                  //       // padding: EdgeInsets.all(12.0),
                  //       children: depositController.depositDetails
                  //           .map((depositDetail) {
                  //         if (depositDetail.title == wallet.currency) {
                  //           return Column(
                  //             // padding: EdgeInsets.all(12.0),
                  //             children: depositDetail.banks.map((bank) {
                  //               print(bank.accountHolder);
                  //               return Card(
                  //                 child: ListTile(
                  //                   title: Text('Bank Name'),
                  //                   subtitle: Text('TransferWise'),
                  //                   trailing: Container(
                  //                     width: 30.0,
                  //                     padding: EdgeInsets.all(0),
                  //                     child: IconButton(
                  //                       icon: Icon(
                  //                         Icons.content_copy,
                  //                         size: 20.0,
                  //                         color: Colors.brown[900],
                  //                       ),
                  //                       onPressed: () {
                  //                         _copyToClipboard('TransferWise');
                  //                       },
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //           );
                  //           // return Card(
                  //           //   child: InkWell(
                  //           //     onTap: () {},
                  //           //     child: ListTile(
                  //           //       title: Text('Title'),
                  //           //     ),
                  //           //   ),
                  //           // );
                  //         } else {
                  //           return Container();
                  //           // return Card(
                  //           //   child: InkWell(
                  //           //     onTap: () {},
                  //           //     child: ListTile(
                  //           //       title: Text('Empty'),
                  //           //     ),
                  //           //   ),
                  //           // );
                  //         }
                  //       }).toList(),
                  //     );
                  //   }
                  // }),
                  Card(
                    child: ListTile(
                      title: Text('Bank Name'),
                      subtitle: Text('TransferWise'),
                      trailing: Container(
                        width: 30.0,
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            size: 20.0,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {
                            _copyToClipboard('TransferWise');
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Account Holder'),
                      subtitle: Text('B4U Group of Companies, S.L.'),
                      trailing: Container(
                        width: 30.0,
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            size: 20.0,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {
                            _copyToClipboard('TransferWise');
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Ach Routing Number'),
                      subtitle: Text('026073150'),
                      trailing: Container(
                        width: 30.0,
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            size: 20.0,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {
                            _copyToClipboard('TransferWise');
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Address'),
                      subtitle: Text(
                          'TransferWise 19 W 24th Street New York NY 10010 United States'),
                      trailing: Container(
                        width: 30.0,
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            size: 20.0,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {
                            _copyToClipboard('TransferWise');
                          },
                        ),
                      ),
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
