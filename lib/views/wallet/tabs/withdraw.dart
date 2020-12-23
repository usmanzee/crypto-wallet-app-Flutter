import 'package:crypto_template/component/custom_button.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/withdraw_controller.dart';
import 'package:crypto_template/screen/wallet/tabs/withdraw.dart';
import 'package:crypto_template/views/security/enable_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:flutter/services.dart';
import 'package:crypto_template/views/wallet/tabs/wallet_amount_header.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class WithDraw extends StatelessWidget {
  final WalletClass.Wallet wallet;
  final HomeController homeController = Get.find();
  WithDraw({this.wallet});

  final WithdrawController withdrawController = Get.put(WithdrawController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _withDrawAddressValidator = MultiValidator([
    RequiredValidator(errorText: 'Withdrawl Address is required'),
  ]);

  void isFormValid() {}

  _onWithdrawFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      // _registerController.register();
    }
  }

  @override
  Widget build(BuildContext context) {
    // isFormValid();
    return SingleChildScrollView(child: Obx(() {
      return Container(
        child: homeController.user.value.otp
            ? Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    WalletAmountHeader(wallet: wallet),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      // height: 355.0,
                      padding: EdgeInsets.fromLTRB(0.0, 24, 0.0, 24.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Withdrawal Address",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.7),
                                fontFamily: "Popins",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 5.0, bottom: 35.0),
                              child: TextFormField(
                                validator: _withDrawAddressValidator,
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: "Enter your withdrawl address",
                                    hintStyle: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontFamily: "Popins",
                                        fontSize: 15.0)),
                              ),
                            ),
                            wallet.currency == 'xrp'
                                ? Text(
                                    "Withdrawal Tag",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7),
                                      fontFamily: "Popins",
                                    ),
                                  )
                                : Container(width: 0, height: 0),
                            wallet.currency == 'xrp'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, bottom: 35.0),
                                    child: TextFormField(
                                      validator: _withDrawAddressValidator,
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText: "Enter your withdrawl Tag",
                                          hintStyle: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontFamily: "Popins",
                                              fontSize: 15.0)),
                                    ),
                                  )
                                : Container(width: 0, height: 0),
                            Text(
                              "Withdrawal Amount",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.7),
                                fontFamily: "Popins",
                              ),
                            ),
                            TextFormField(
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              controller:
                                  withdrawController.withdrawAmountController,
                              onChanged: (text) {
                                withdrawController
                                    .withdrawAmountController.text = text;
                              },
                              decoration: InputDecoration(
                                  hintText: "0.0",
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontFamily: "Popins",
                                      fontSize: 15.0)),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "24H Withdrawal Limit: 2 BTC",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontFamily: "Popins",
                                    fontSize: 12.0),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "2FA Code",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.7),
                                fontFamily: "Popins",
                              ),
                            ),
                            TextField(
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText:
                                      "Enter 2FA code from authenticator app",
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).hintColor,
                                      fontFamily: "Popins",
                                      fontSize: 15.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Fee",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.5)),
                              ),
                              Text(
                                wallet.fee +
                                    ' ' +
                                    wallet.currency.toUpperCase(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Total Withdrawl Amount",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.5)),
                              ),
                              Text(
                                withdrawController
                                    .withdrawAmountController.text,
                                // "-0.001 BCH",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CustomButton(
                      height: 50.0,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      label: 'Withdraw',
                      onPressed: () {
                        _onWithdrawFormSubmit();
                      },
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      disabled: false,
                    ),
                    // MaterialButton(
                    //   height: 50.0,
                    //   minWidth: double.infinity,
                    //   color: Theme.of(context).primaryColor,
                    //   // disabledColor: Colors.grey,
                    //   // disabledTextColor: Colors.black,
                    //   textColor: Colors.white,
                    //   child: Text(
                    //     "Withdraw",
                    //   ),
                    //   onPressed: () {
                    //     _onWithdrawFormSubmit();
                    //   },
                    //   splashColor:
                    //       Theme.of(context).primaryColor.withOpacity(0.5),
                    // ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              )
            : _withdrawNotEnabled(context),
      );
    }));
  }

  Widget _withdrawNotEnabled(context) {
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
            'To withdraw you have to enable 2FA',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: 40.0,
          width: 150.0,
          color: Theme.of(context).primaryColor,
          child: GestureDetector(
            onTap: () {
              Get.to(EnableOTP());
            },
            child: Center(
              child: Text(
                "Enable 2FA",
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
}
