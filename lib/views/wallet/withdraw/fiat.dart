import 'package:crypto_template/controllers/fiat_withdraw_controller.dart';
import 'package:crypto_template/views/wallet/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/component/custom_button.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/views/security/enable_otp.dart';
import 'package:form_field_validator/form_field_validator.dart';

class WithdrawFiat extends StatefulWidget {
  final WalletClass.Wallet wallet;
  WithdrawFiat({Key key, this.wallet}) : super(key: key);

  @override
  _WithdrawFiatState createState() => _WithdrawFiatState(wallet: wallet);
}

class _WithdrawFiatState extends State<WithdrawFiat> {
  final WalletClass.Wallet wallet;
  _WithdrawFiatState({this.wallet});

  String dropdownValue = 'One';

  final HomeController homeController = Get.find();
  FiatWithdrawController withdrawController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    withdrawController = Get.put(FiatWithdrawController(wallet: wallet));
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                    height: 30.0,
                                    width: 40.0,
                                    color: Theme.of(context).accentColor,
                                    textColor: Colors.white,
                                    label: 'Add Beneficiary',
                                    onPressed: () {
                                      // _onWithdrawFormSubmit();
                                    },
                                    splashColor: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.5),
                                    disabled: false,
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    // style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      // color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'One',
                                      'Two',
                                      'Free',
                                      'Four'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ]),
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
