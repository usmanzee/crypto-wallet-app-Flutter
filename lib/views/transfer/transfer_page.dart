import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/transfer_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/transfer/currency_selection_page.dart';
import 'package:b4u_wallet/views/transfer/wallets_list_page.dart';
import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferPage extends StatelessWidget {
  final _transferController = Get.find<TransferController>();
  final WalletController walletController = Get.find<WalletController>();
  final String spotName = 'Spot';
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // print(homeController.user.value.otp);
    // print(homeController.publicMemberLevel.value.withdraw.minimumLevel);
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
      body: Obx(
        () {
          if (walletController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _transferController.currentWalletList.length == 0
                ? _transferController.currentWalletList
                    .addAll(walletController.p2pWalletsList)
                : print('a');
            if (_transferController.currencyName.value == '') {
              _transferController.currencyName.value =
                  _transferController.currentWalletList.length == 0
                      ? ''
                      : _transferController.currentWalletList[0].currency;
            }
            if (_transferController.currencyTotal.value == '') {
              _transferController.currencyTotal.value =
                  _transferController.currentWalletList.length == 0
                      ? ''
                      : _transferController.currentWalletList[0].balance;
            }
            if (_transferController.currencyImage.value == '') {
              _transferController.currencyImage.value =
                  _transferController.currentWalletList.length == 0
                      ? ''
                      : _transferController.currentWalletList[0].iconUrl;
              print(_transferController.currencyImage.value);
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
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
                                        _transferController.swap.value
                                            ? Icons.scatter_plot_outlined
                                            : _transferController.walletIcon,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('From'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      _transferController.swap.value
                                          ? Text(
                                              '$spotName Wallet',
                                              style: TextStyle(
                                                fontFamily: "Popins",
                                                color: Get
                                                    .theme
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          : _walletType(
                                              walletName: _transferController
                                                  .walletName.value,
                                              callback: () => Get.to(
                                                () =>
                                                    WalletsList(walletCallback),
                                              ),
                                            ),
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
                                        _transferController.swap.value
                                            ? _transferController.walletIcon
                                            : Icons.scatter_plot_outlined,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('To    '),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      _transferController.swap.value
                                          ? _walletType(
                                              walletName: _transferController
                                                  .walletName.value,
                                              callback: () => Get.to(
                                                () =>
                                                    WalletsList(walletCallback),
                                              ),
                                            )
                                          : Text(
                                              '$spotName Wallet',
                                              style: TextStyle(
                                                fontFamily: "Popins",
                                                color: Get
                                                    .theme
                                                    .textSelectionTheme
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
                                  _transferController.swap.value =
                                      !_transferController.swap.value;
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
                              // walletController.walletsList = spot wallet list
                              Get.to(
                                CurrencySelection(
                                  // callback: currencyCallback,
                                  walletData: _transferController.swap.value
                                      ? walletController.walletsList
                                      : _transferController.currentWalletList,
                                ),
                              );
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      iconWidget(
                                        name: _transferController
                                            .currencyName.value,
                                        url: _transferController
                                            .currencyImage.value,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _transferController.currencyName.value
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            color: Get.theme.textSelectionTheme
                                                .selectionColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
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
                                    _transferController.textController.value =
                                        TextEditingValue(
                                      text: string,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: string.length),
                                      ),
                                    );
                                  },
                                  controller:
                                      _transferController.textController,
                                  focusNode: _transferController.focusNode,
                                  keyboardType: TextInputType.number,
                                  maxLength: 20,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    border: InputBorder.none,
                                    counterText: '',
                                    suffix: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _transferController.textController.value
                                                    .text ==
                                                ''
                                            ? Container()
                                            : Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Get.theme.accentColor
                                                      .withOpacity(0.8),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _transferController
                                                        .textController
                                                        .clear();
                                                    _transferController
                                                        .focusNode
                                                        .unfocus();
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 15,
                                                    color: Get.theme
                                                        .scaffoldBackgroundColor,
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
                                      _transferController.currencyName.value
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
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
                                        //click for adding the whole value to the textController.
                                        _transferController
                                                .textController.text =
                                            _transferController
                                                .currencyTotal.value;
                                        _transferController.focusNode
                                            .requestFocus();
                                      },
                                      child: Text(
                                        'MAX',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Get.theme.accentColor
                                              .withOpacity(0.8),
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
                          'Available Balance ${_transferController.currencyTotal.value} ${_transferController.currencyName.value.toUpperCase()}',
                          style: TextStyle(
                            fontFamily: "Popins",
                            color: Get.theme.textSelectionTheme.selectionColor
                                .withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomSheet: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: walletController.walletsList.length == 0
                  ? null
                  : _transferController.transferButtonText.value ==
                          'Verify your account'
                      ? () => Get.toNamed('/profile-verification')
                      : (_transferController.transferButtonText.value ==
                              'Transfer'
                          ? () async {
                              //todo: get a variable here from the server to replace the hardcoded 3 here
                              if (homeController.user.value.level ==
                                  homeController.publicMemberLevel.value
                                      .withdraw.minimumLevel) {
                                if (homeController.user.value.otp) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                                  final res =
                                      await _transferController.transferAsset(
                                    amount: _transferController
                                        .textController.value.text,
                                    currencyCode:
                                        _transferController.currencyName.value,
                                    sourceWallet: _transferController.swap.value
                                        ? spotName.toLowerCase()
                                        : _transferController.walletName
                                            .toLowerCase(),
                                    targetWallet: _transferController.swap.value
                                        ? _transferController.walletName
                                            .toLowerCase()
                                        : spotName.toLowerCase(),
                                  );
                                  if (res) {
                                    Get.back();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Amount Transferred'),
                                    ));
                                  } else {
                                    Get.back();
                                  }
                                } else {
                                  // here is the text which will change to the 2fa.
                                  _transferController.transferButtonText.value =
                                      'Enable 2FA';
                                }
                              } else {
                                // here is the text which will change to the account verification.
                                _transferController.transferButtonText.value =
                                    'Verify your account';
                              }
                            }
                          : () => Get.toNamed('/enable-otp')),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: walletController.walletsList.length == 0
                      ? Get.theme.canvasColor
                      : Get.theme.accentColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    _transferController.transferButtonText.value,
                    style: TextStyle(
                      fontFamily: "Popins",
                      color: walletController.walletsList.length == 0
                          ? Get.theme.textSelectionTheme.selectionColor
                          : Get.theme.scaffoldBackgroundColor,
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
    _transferController.currencyImage.value = icon;
    _transferController.currencyName.value = name;
    _transferController.currencyTotal.value = total;

    if (_transferController.currencyImage.value == null) {
      _transferController.currencyImage.value = MyImgs.testPhoto;
    }
    print(_transferController.currencyName.value);
  }

//callback for fetching the wallet type from the wallet list.
  void walletCallback({String name, IconData icon}) {
    _transferController.walletName.value = name;
    _transferController.walletIcon = icon;
  }
}
