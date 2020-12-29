import 'package:crypto_template/views/wallet/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/component/custom_button.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/crypto_withdraw_controller.dart';
import 'package:crypto_template/views/security/enable_otp.dart';
import 'package:crypto_template/views/wallet/wallet_amount_header.dart';
import 'package:form_field_validator/form_field_validator.dart';

class WithdrawCrypto extends StatefulWidget {
  final WalletClass.Wallet wallet;
  WithdrawCrypto({Key key, this.wallet}) : super(key: key);

  @override
  _WithdrawCryptoState createState() => _WithdrawCryptoState(wallet: wallet);
}

class _WithdrawCryptoState extends State<WithdrawCrypto> {
  final WalletClass.Wallet wallet;
  _WithdrawCryptoState({this.wallet});

  final HomeController homeController = Get.find();
  CryptoWithdrawController withdrawController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _withDrawAddressValidator = MultiValidator([
    RequiredValidator(errorText: 'Withdrawl Address is required'),
  ]);
  final _withDrawTagValidator = MultiValidator([
    RequiredValidator(errorText: 'Withdrawl Tag is required'),
  ]);

  final _twoFAValidator = MultiValidator([
    RequiredValidator(errorText: '2FA code is required'),
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'Please enter a valid 2FA code')
  ]);

  void isFormValid() {}

  _onWithdrawFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      withdrawController.withdraw(_formKey);
    }
  }

  @override
  void initState() {
    withdrawController = Get.put(CryptoWithdrawController(wallet: wallet));
    print('widget init');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: WalletCustomAppbar(
          title: 'Withdraw',
          screenType: 'withdraw',
          wallet: wallet,
        ),
      ),
      body: SingleChildScrollView(child: Obx(() {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: homeController.user.value.otp
              ? Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // WalletAmountHeader(wallet: wallet),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        // height: 355.0,
                        // padding: EdgeInsets.fromLTRB(0.0, 24, 0.0, 24.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // color: Theme.of(context).canvasColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
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
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: TextFormField(
                                controller: withdrawController
                                    .withdrawAddressController,
                                validator: _withDrawAddressValidator,
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontSize: 13.5,
                                    ),
                                    errorMaxLines: 3,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    labelText: 'Address',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
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
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: TextFormField(
                                      controller: withdrawController
                                          .withdrawTagController,
                                      validator: _withDrawTagValidator,
                                      obscureText: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                            fontSize: 13.5,
                                          ),
                                          errorMaxLines: 3,
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: 'Tag',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: TextFormField(
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                validator: (amount) {
                                  if (withdrawController
                                          .totalWithdrawlAmount.value >
                                      double.parse(wallet.balance)) {
                                    return 'Please enter a valid amount';
                                  } else {
                                    return null;
                                  }
                                },
                                controller:
                                    withdrawController.withdrawAmountController,
                                onChanged: (amount) {
                                  var validAmount =
                                      amount != null && amount != ''
                                          ? amount
                                          : '0.0';
                                  withdrawController.amount.value = validAmount;
                                  withdrawController
                                          .totalWithdrawlAmount.value =
                                      double.parse(validAmount) +
                                          double.parse(wallet.fee);
                                },
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontSize: 13.5,
                                    ),
                                    errorMaxLines: 3,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    labelText: 'Amount',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
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
                            TextFormField(
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              controller:
                                  withdrawController.withdrawOtpController,
                              validator: _twoFAValidator,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontSize: 13.5,
                                  ),
                                  errorMaxLines: 3,
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  labelText: '2FA',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ],
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
                                  (withdrawController
                                          .totalWithdrawlAmount.value)
                                      .toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.7)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              width: double.infinity,
                              height: 0.5,
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
                                    '* Do not withdraw directly to a crowdfund or ICO address, as your account will not be credited with tokens from such sales.',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '* When withdrawing to the B4U user\'s address, the handling fee will be returned to the Current Account by default.',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ]),
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
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                )
              : _withdrawNotEnabled(context),
        );
      })),
    );
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
