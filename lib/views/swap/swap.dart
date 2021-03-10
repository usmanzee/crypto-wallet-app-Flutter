import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/swap_controller.dart';
import 'package:crypto_template/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/models/wallet.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Swap extends StatelessWidget {
  final SwapController swapController = Get.put(SwapController());
  // final SwapController swapController = Get.find();
  final WalletController walletController = Get.find();
  final HomeController homeController = Get.find();

  final FocusNode _fromFieldfocus = new FocusNode();
  final FocusNode _toFieldfocus = new FocusNode();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  final _twoFAValidator = MultiValidator([
    RequiredValidator(errorText: '2FA code is required'),
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'Please enter a valid 2FA code')
  ]);

  void _onKeyPressed(int key) {
    if (_fromFieldfocus.hasFocus) {
      if (key == NumericalKeyboard.backspaceKey) {
        if (swapController.fromAmountTextController.text.length > 0) {
          swapController.fromAmountTextController.text =
              swapController.fromAmountTextController.text.substring(
                  0, swapController.fromAmountTextController.text.length - 1);
        }
      } else {
        if (key == NumericalKeyboard.decimalPoint) {
          swapController.fromAmountTextController.text += '.';
        } else {
          swapController.fromAmountTextController.text += key.toString();
        }
      }
    }
  }

  _onExchangeFormSubmit() async {
    final _formState = _otpFormKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      Get.back();
      swapController.exchangeRequest();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          centerTitle: true,
          title: Text(
            'Buy/Sell',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
          elevation: 0.8,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/swap-history');
                  },
                  child: Icon(
                    Icons.history,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: Obx(() {
          return Container(
            child: homeController.fetchingUser.value &&
                    homeController.fetchingMemberLevel.value
                ? Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : homeController.user.value.otp
                    ? (homeController.user.value.level >=
                            homeController
                                .publicMemberLevel.value.withdraw.minimumLevel
                        ? _swapForm(context)
                        : _accountNotConfirmed(context))
                    : _otpDisabled(context),
          );
        }));
  }

  Widget _otpDisabled(context) {
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
        Center(
          child: Text(
            'To Exchange you have to enable 2FA',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        MaterialButton(
          minWidth: 100,
          splashColor: Colors.black12,
          highlightColor: Colors.black12,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Get.toNamed('/enable-otp');
          },
          child: Center(
              child: Text(
            "Enable 2FA",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Popins",
                letterSpacing: 1.3,
                fontSize: 16.0),
          )),
        ),
        SizedBox(
          height: 16.0,
        ),
      ]),
    );
  }

  Widget _accountNotConfirmed(context) {
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
        Center(
          child: Text(
            'To Exchange you have to confirm your account',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        MaterialButton(
          minWidth: 100,
          splashColor: Colors.black12,
          highlightColor: Colors.black12,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Get.toNamed('/profile-verification');
          },
          child: Center(
              child: Text(
            "Confirm Account",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Popins",
                letterSpacing: 1.3,
                fontSize: 16.0),
          )),
        ),
        SizedBox(
          height: 16.0,
        ),
      ]),
    );
  }

  Widget _swapForm(context) {
    // print(homeController.publicMemberLevel.value.toString());
    return Obx(() {
      if (swapController.isLoading.value)
        return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: MediaQuery.of(context).size.height / 2.2,
            width: double.infinity,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      else
        return Padding(
          padding: EdgeInsets.fromLTRB(8, 40, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(
                            fontFamily: "Popins",
                            color: Theme.of(context).hintColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(children: [
                        Text(
                          'Available: ',
                          style: TextStyle(
                              fontFamily: "Popins",
                              color: Theme.of(context).hintColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w100),
                        ),
                        Text(
                          swapController.fromSelectedWallet.value.balance,
                          style: TextStyle(
                              fontFamily: "Popins",
                              color: Theme.of(context).textSelectionColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            swapController.fromSelectedWallet.value.currency
                                .toUpperCase(),
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Theme.of(context).textSelectionColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            swapController.selectedWalletIndex.value = 0;
                            swapController.setSearchWallets();
                            showWalletsList(context);
                          },
                          child: Row(
                            children: [
                              swapController.fromSelectedWallet.value.iconUrl !=
                                      null
                                  ? Image.network(
                                      swapController
                                          .fromSelectedWallet.value.iconUrl,
                                      height: 25.0,
                                      fit: BoxFit.contain,
                                      width: 22.0,
                                    )
                                  : Image.asset(
                                      'assets/image/market/BCH.png',
                                      height: 22.0,
                                      fit: BoxFit.contain,
                                      width: 22.0,
                                    ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  swapController
                                      .fromSelectedWallet.value.currency
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      color:
                                          Theme.of(context).textSelectionColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        Container(
                            height: 16,
                            child: VerticalDivider(
                                color: Theme.of(context).textSelectionColor)),
                        Flexible(
                          child: TextFormField(
                            focusNode: _fromFieldfocus,
                            controller: swapController.fromAmountTextController,
                            autofocus: true,
                            showCursor: true,
                            readOnly: true,
                            cursorColor: Theme.of(context).textSelectionColor,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: swapController.fromSelectedWallet
                                        .value.minSwapAmount +
                                    ' - ' +
                                    swapController.fromSelectedWallet.value
                                        .maxSwapAmount),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Container(
                              height: 16,
                              child: VerticalDivider(
                                  color: Theme.of(context).textSelectionColor)),
                        ),
                        GestureDetector(
                          onTap: () {
                            swapController.fromAmountTextController.text = '';
                            swapController.fromAmountTextController.text =
                                swapController.fromSelectedWallet.value.balance;
                          },
                          child: Text(
                            'Max',
                            style: TextStyle(
                                fontFamily: "Popins",
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (swapController.fromFieldErrorText.value != '')
                Text(
                  swapController.fromFieldErrorText.value,
                  style: TextStyle(
                      fontFamily: "Popins",
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w100),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text(
                  'To',
                  style: TextStyle(
                      fontFamily: "Popins",
                      color: Theme.of(context).hintColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            swapController.selectedWalletIndex.value = 1;
                            swapController.setSearchWallets();
                            showWalletsList(context);
                          },
                          child: Row(
                            children: [
                              swapController.toSelectedWallet.value.iconUrl !=
                                      null
                                  ? Image.network(
                                      swapController
                                          .toSelectedWallet.value.iconUrl,
                                      height: 25.0,
                                      fit: BoxFit.contain,
                                      width: 22.0,
                                    )
                                  : Image.asset(
                                      'assets/image/market/BCH.png',
                                      height: 22.0,
                                      fit: BoxFit.contain,
                                      width: 22.0,
                                    ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  swapController.toSelectedWallet.value.currency
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      color:
                                          Theme.of(context).textSelectionColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        Container(
                            height: 16,
                            child: VerticalDivider(
                                color: Theme.of(context).textSelectionColor)),
                        Flexible(
                          child: TextFormField(
                            focusNode: _toFieldfocus,
                            cursorColor: Theme.of(context).textSelectionColor,
                            keyboardType: TextInputType.number,
                            showCursor: true,
                            readOnly: true,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "--"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    NumericalKeyboard(
                      onKeyPressed: _onKeyPressed,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 40.0,
                        child: MaterialButton(
                          splashColor: Colors.black12,
                          highlightColor: Colors.black12,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            swapController.handleFromFieldErrror();
                            if (swapController.fromAmountTextController.text !=
                                    '' &&
                                !swapController.fromFieldError) {
                              showRate(context);
                              swapController.fetchExchangeRate();
                            }
                          },
                          child: Center(
                              child: Text(
                            "Preview Rates",
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
    });
  }

  Widget line(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        decoration: BoxDecoration(color: Theme.of(context).hintColor),
      ),
    );
  }

  void showWalletsList(BuildContext context) {
    // swapController.searchWalletsList.assignAll(swapController.walletsList);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return Obx(() {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.fromLTRB(8, 24, 8, 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 56,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    color: swapController
                                                .selectedWalletIndex.value ==
                                            0
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor
                                        : Theme.of(context).canvasColor,
                                    onPressed: () {
                                      swapController.selectedWalletIndex.value =
                                          0;
                                      swapController.setSearchWallets();
                                    },
                                    child: Center(
                                        child: Row(children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Text(
                                          'From',
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      swapController.fromSelectedWallet.value
                                                  .iconUrl !=
                                              null
                                          ? Image.network(
                                              swapController.fromSelectedWallet
                                                  .value.iconUrl,
                                              height: 25.0,
                                              fit: BoxFit.contain,
                                              width: 22.0,
                                            )
                                          : Image.asset(
                                              'assets/image/market/BCH.png',
                                              height: 22.0,
                                              fit: BoxFit.contain,
                                              width: 22.0,
                                            ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          swapController
                                              .fromSelectedWallet.value.currency
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ])),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 56,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    color: swapController
                                                .selectedWalletIndex.value ==
                                            1
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor
                                        : Theme.of(context).canvasColor,
                                    onPressed: () {
                                      swapController.selectedWalletIndex.value =
                                          1;
                                      swapController.setSearchWallets();
                                    },
                                    child: Center(
                                        child: Row(children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Text(
                                          'To',
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      swapController.toSelectedWallet.value
                                                  .iconUrl !=
                                              null
                                          ? Image.network(
                                              swapController.toSelectedWallet
                                                  .value.iconUrl,
                                              height: 25.0,
                                              fit: BoxFit.contain,
                                              width: 22.0,
                                            )
                                          : Image.asset(
                                              'assets/image/market/BCH.png',
                                              height: 22.0,
                                              fit: BoxFit.contain,
                                              width: 22.0,
                                            ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          swapController
                                              .toSelectedWallet.value.currency
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ])),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          swapController.selectedWalletIndex.value == 0
                              ? 'Convert From'
                              : 'Convert To',
                          style: TextStyle(
                              fontFamily: "Popins",
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: 16.0),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Theme.of(context).canvasColor,
                        //     border: Border.all(
                        //       color: Theme.of(context).scaffoldBackgroundColor,
                        //       width: 3.0,
                        //     ),
                        //     borderRadius: BorderRadius.circular(16.0),
                        //   ),
                        //   child: Row(
                        //     children: <Widget>[
                        //       Padding(
                        //         padding: EdgeInsets.only(left: 8),
                        //         child: Icon(
                        //           Icons.search,
                        //           size: 20,
                        //           color: Theme.of(context).hintColor,
                        //         ),
                        //       ),
                        //       new Expanded(
                        //         child: TextField(
                        //           onChanged: swapController
                        //               .handleSearchInputChangeEvent,
                        //           cursorColor: Theme.of(context).hintColor,
                        //           keyboardType: TextInputType.text,
                        //           decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintText: "Search...",
                        //             hintStyle: TextStyle(
                        //                 color: Theme.of(context).hintColor),
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: 8, horizontal: 8),
                        //             isDense: true,
                        //           ),
                        //           style: TextStyle(
                        //             fontSize: 14.0,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 8.0),
                        Expanded(
                          child: swapController.searchWalletsList.length < 0
                              ? NoData()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return walletList(ctx,
                                        swapController.searchWalletsList[i]);
                                  },
                                  itemCount:
                                      swapController.searchWalletsList.length,
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: FlatButton(
                                    color: Theme.of(context).canvasColor,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontFamily: "Popins",
                                            color: Theme.of(context)
                                                .textSelectionColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontFamily: "Popins",
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            );
          });
        });
  }

  Widget walletList(BuildContext ctx, Wallet wallet) {
    return ListTile(
      leading: wallet.iconUrl != null
          ? Image.network(
              wallet.iconUrl,
              fit: BoxFit.contain,
              width: 25.0,
            )
          : Image.asset(
              'assets/image/market/BCH.png',
              fit: BoxFit.contain,
              width: 25.0,
            ),
      title: Text(wallet.currency.toUpperCase()),
      subtitle: Text(wallet.name),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        swapController.setWalletOnClick(wallet);
        // if (swapController.selectedWalletIndex.value == 0) {
        //   swapController.setFromSelectedWallet(wallet);
        //   swapController.selectedWalletIndex.value = 1;
        // } else {
        //   swapController.setToSelectedWallet(wallet);
        // }
      },
    );
  }

  void showRate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (ctx) {
          return Obx(() {
            if (swapController.isLoadingExchangeRate.value) {
              return FractionallySizedBox(
                heightFactor: 0.5,
                child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height / 2.2,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
              );
            } else {
              return FractionallySizedBox(
                heightFactor: 0.8,
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text('Confirm Conversion',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Popins",
                                    letterSpacing: 1.3,
                                    fontSize: 16.0)),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Text('You will receive',
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontFamily: "Popins",
                                    letterSpacing: 1.3,
                                    fontSize: 14.0)),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Center(
                            child: Text(
                                swapController.receivableAmount.value +
                                    ' ' +
                                    swapController
                                        .toSelectedWallet.value.currency
                                        .toUpperCase(),
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Popins",
                                    fontSize: 24.0)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            color: Theme.of(context).canvasColor,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price',
                                      style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Theme.of(context).hintColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '1 ' +
                                              swapController.fromSelectedWallet
                                                  .value.currency
                                                  .toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' ≃ ',
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          double.parse(swapController
                                                      .exchangeRate.value)
                                                  .toStringAsFixed(5) +
                                              ' ' +
                                              swapController.toSelectedWallet
                                                  .value.currency
                                                  .toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Fee %',
                                      style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Theme.of(context).hintColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      (double.parse(swapController
                                                  .toSelectedWallet
                                                  .value
                                                  .swapFee) *
                                              100)
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: "Popins",
                                          color: Theme.of(context)
                                              .textSelectionColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'You will get',
                                //       style: TextStyle(
                                //           fontFamily: "Popins",
                                //           color: Theme.of(context).hintColor,
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //     Text(
                                //       swapController
                                //               .fromAmountTextController.text +
                                //           ' ' +
                                //           swapController.fromSelectedWallet
                                //               .value.currency
                                //               .toUpperCase(),
                                //       style: TextStyle(
                                //           fontFamily: "Popins",
                                //           color: Theme.of(context)
                                //               .textSelectionColor,
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.bold),
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Enter 2FA Code to proceed",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Popins",
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: <Widget>[
                                new Expanded(
                                  child: Form(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    key: _otpFormKey,
                                    child: PinCodeTextField(
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      length: 6,
                                      obscureText: false,
                                      animationType: AnimationType.fade,
                                      pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          inactiveColor: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.6),
                                          borderWidth: 1,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                          selectedColor:
                                              Theme.of(context).primaryColor,
                                          activeColor: Theme.of(context)
                                              .textSelectionColor),
                                      cursorColor:
                                          Theme.of(context).textSelectionColor,
                                      animationDuration:
                                          Duration(milliseconds: 300),
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      controller:
                                          swapController.otpCodeTextController,
                                      autoDisposeControllers: false,
                                      keyboardType: TextInputType.number,
                                      validator: _twoFAValidator,
                                      onCompleted: (v) {},
                                      onChanged: (value) {},
                                      beforeTextPaste: (text) {
                                        print("Allowing to paste $text");
                                        return true;
                                      },
                                    ),
                                    // TextFormField(
                                    //   obscureText: false,
                                    //   keyboardType: TextInputType.number,
                                    //   controller:
                                    //       swapController.otpCodeTextController,
                                    //   validator: _twoFAValidator,
                                    //   cursorColor: Theme.of(context).hintColor,
                                    //   decoration: InputDecoration(
                                    //     errorStyle: TextStyle(
                                    //       fontSize: 13.5,
                                    //     ),
                                    //     errorMaxLines: 3,
                                    //     filled: true,
                                    //     fillColor: Colors.transparent,
                                    //     labelText: '2FA Code to Confirm',
                                    //     border: OutlineInputBorder(
                                    //         borderRadius: BorderRadius.circular(5)),
                                    //     hintStyle: TextStyle(
                                    //         color: Theme.of(context).hintColor),
                                    //     contentPadding: EdgeInsets.symmetric(
                                    //         vertical: 12, horizontal: 12),
                                    //     isDense: true,
                                    //   ),
                                    //   style: TextStyle(
                                    //     fontSize: 14.0,
                                    //     color: Theme.of(context).textSelectionColor,
                                    //   ),
                                    // ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: FlatButton(
                                      color: Theme.of(context).canvasColor,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Center(
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Theme.of(context)
                                                  .textSelectionColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: FlatButton(
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        _onExchangeFormSubmit();
                                      },
                                      child: Center(
                                        child: Text(
                                          'Convert',
                                          style: TextStyle(
                                              fontFamily: "Popins",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
              );
            }
          });
        });
  }
}

typedef KeyboardCallback(int key);

class NumericalKeyboard extends StatelessWidget {
  const NumericalKeyboard({Key key, this.onKeyPressed}) : super(key: key);

  static const backspaceKey = 42;
  static const decimalPoint = 110;
  static const clearKey = 69;

  final KeyboardCallback onKeyPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.grey[200],
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(flex: 1.0),
        // border: TableBorder.all(),
        children: [
          TableRow(
            children: [
              _buildNumberKey(context, 1),
              _buildNumberKey(context, 2),
              _buildNumberKey(context, 3),
            ],
          ),
          TableRow(
            children: [
              _buildNumberKey(context, 4),
              _buildNumberKey(context, 5),
              _buildNumberKey(context, 6),
            ],
          ),
          TableRow(
            children: [
              _buildNumberKey(context, 7),
              _buildNumberKey(context, 8),
              _buildNumberKey(context, 9),
            ],
          ),
          TableRow(
            children: [
              _buildKey(
                  Text(
                    '.',
                    style: TextStyle(
                        fontFamily: "Popins",
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  decimalPoint),
              _buildNumberKey(context, 0),
              _buildKey(Icon(Icons.backspace), backspaceKey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberKey(BuildContext context, int n) {
    return _buildKey(
      Text('$n',
          style: TextStyle(
              fontFamily: "Popins",
              color: Theme.of(context).textSelectionColor,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      n,
    );
  }

  Widget _buildKey(Widget icon, int key) {
    return IconButton(
      icon: icon,
      padding: EdgeInsets.all(16.0),
      onPressed: () => onKeyPressed(key),
    );
  }
}

class NoKeyboardEditableText extends EditableText {
  NoKeyboardEditableText(
      {@required TextEditingController controller,
      @required TextStyle style,
      @required Color cursorColor,
      bool autofocus = false,
      Color selectionColor})
      : super(
            controller: controller,
            focusNode: NoKeyboardEditableTextFocusNode(),
            style: style,
            cursorColor: cursorColor,
            autofocus: autofocus,
            selectionColor: selectionColor,
            backgroundCursorColor: Colors.black);

  @override
  EditableTextState createState() {
    return NoKeyboardEditableTextState();
  }
}

class NoKeyboardEditableTextState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}
