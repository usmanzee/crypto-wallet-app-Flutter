import 'package:crypto_template/controllers/fiat_withdraw_controller.dart';
import 'package:crypto_template/models/Beneficiary.dart';
import 'package:crypto_template/views/beneficiary/add_beneficiary.dart';
import 'package:crypto_template/views/wallet/search_wallet_header.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/component/custom_button.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WithdrawFiat extends StatefulWidget {
  final WalletClass.Wallet wallet;
  WithdrawFiat({Key key, this.wallet}) : super(key: key);

  @override
  _WithdrawFiatState createState() => _WithdrawFiatState(wallet: wallet);
}

class _WithdrawFiatState extends State<WithdrawFiat> {
  final WalletClass.Wallet wallet;
  _WithdrawFiatState({this.wallet});

  final HomeController homeController = Get.find();
  FiatWithdrawController withdrawController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _twoFAValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'fiat_withdraw.screen.field.2fa.error'.tr)
  ]);
  final _beneficiaryValidator = MultiValidator([
    RequiredValidator(
        errorText: 'fiat_withdraw.screen.field.beneficiary.error'.tr),
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
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'fiat_withdraw.screen.title'.tr,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1.0,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Obx(() {
        return Column(children: [
          SearchHeader(
            screenType: 'withdraw',
            wallet: wallet,
          ),
          Expanded(
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: homeController.fetchingUser.value &&
                        homeController.fetchingMemberLevel.value
                    ? Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator())
                    : homeController.user.value.otp
                        ? (homeController.user.value.level >=
                                homeController.publicMemberLevel.value.withdraw
                                    .minimumLevel
                            ? _withdrawlForm(context)
                            : _accountNotConfirmed(context))
                        : _otpDisabled(context),
              ),
            ]),
          ),
          if (!homeController.fetchingUser.value &&
              !homeController.fetchingMemberLevel.value &&
              wallet.withdrawEnabled &&
              homeController.user.value.otp &&
              (homeController.user.value.level >=
                  homeController.publicMemberLevel.value.withdraw.minimumLevel))
            _bottomButton(context)
        ]);
      }),
    );
  }

  Widget _withdrawlForm(context) {
    return Obx(() {
      if (withdrawController.isBeneficiariesLoading.value)
        return Container(
            width: double.infinity,
            height: 200,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      else {
        return wallet.withdrawEnabled
            ? Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomButton(
                        height: 30.0,
                        width: 40.0,
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        label: 'fiat_withdraw.screen.button.add_beneficiary'.tr,
                        onPressed: () {
                          Get.to(AddBeneficiary(wallet: wallet));
                        },
                        splashColor:
                            Theme.of(context).accentColor.withOpacity(0.5),
                        disabled: false,
                      ),
                      if (withdrawController.beneficiariesList.length > 0)
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "fiat_withdraw.screen.field.beneficiary".tr,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.7),
                                  fontFamily: "Popins",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: FormField<String>(
                                  // validator: _beneficiaryValidator,
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: withdrawController
                                              .selectedWithdrawBeneficiary
                                              .value
                                              .id
                                              .toString(),
                                          isDense: true,
                                          onChanged: (String newOptionValue) {
                                            var newOption = withdrawController
                                                .beneficiariesList
                                                .where((Beneficiary
                                                        beneficiary) =>
                                                    beneficiary.id ==
                                                    int.parse(newOptionValue))
                                                .single;
                                            withdrawController
                                                .selectedWithdrawBeneficiary
                                                .value = newOption;
                                            setState(() {
                                              state.didChange(newOptionValue);
                                            });
                                          },
                                          items: withdrawController
                                              .beneficiariesList
                                              .map((Beneficiary beneficiary) {
                                            return DropdownMenuItem<String>(
                                              value: beneficiary.id.toString(),
                                              child: Text(
                                                  beneficiary.name.toString()),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ])
                      else
                        Container(),
                      Text(
                        "fiat_withdraw.screen.field.amount".tr,
                        style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontFamily: "Popins",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (amount) {
                            if (withdrawController.totalWithdrawlAmount.value >
                                    double.parse(wallet.balance) ||
                                amount == '') {
                              return 'fiat_withdraw.screen.field.amount.error'
                                  .tr;
                            } else {
                              return null;
                            }
                          },
                          controller:
                              withdrawController.withdrawAmountController,
                          onChanged: (amount) {
                            var validAmount =
                                amount != null && amount != '' ? amount : '0.0';
                            withdrawController.amount.value = validAmount;
                            withdrawController.totalWithdrawlAmount.value =
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Text(
                        "fiat_withdraw.screen.field.2fa".tr,
                        style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                          fontFamily: "Popins",
                        ),
                      ),
                      PinCodeTextField(
                        appContext: context,
                        textInputAction: TextInputAction.done,
                        pastedTextStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textStyle: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.w600,
                        ),
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            inactiveColor:
                                Theme.of(context).hintColor.withOpacity(0.6),
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            selectedColor: Theme.of(context).primaryColor,
                            activeColor: Theme.of(context).textSelectionColor),
                        cursorColor: Theme.of(context).textSelectionColor,
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        controller: withdrawController.withdrawOtpController,
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
                                  "fiat_withdraw.screen.fee".tr,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: 14,
                                    fontFamily: "Popins",
                                  ),
                                ),
                                Text(
                                  wallet.fee +
                                      ' ' +
                                      wallet.currency.toUpperCase(),
                                  style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Popins",
                                  ),
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
                                  "fiat_withdraw.screen.total_amount".tr,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.7),
                                    fontSize: 14,
                                    fontFamily: "Popins",
                                  ),
                                ),
                                Text(
                                  (withdrawController
                                          .totalWithdrawlAmount.value)
                                      .toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Popins",
                                  ),
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
                    ]),
              )
            : _withDdrawDisabled(context);
      }
    });
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.fromLTRB(4, 8, 4, 4),
      child: Column(children: [
        CustomButton(
          height: 50.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          label: 'fiat_withdraw.screen.button.withdraw'.tr,
          onPressed: () {
            _onWithdrawFormSubmit();
          },
          splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
          disabled: false,
        ),
      ]),
    );
  }

  Widget _withDdrawDisabled(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      width: double.infinity,
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
            'fiat_withdraw.screen.withdraw_disabled'.tr,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
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
      width: double.infinity,
      child: Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Center(
          child: Text(
            'fiat_withdraw.screen.confirm_account'.tr,
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
            "fiat_withdraw.screen.button.confirm_account".tr,
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

  Widget _otpDisabled(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      width: double.infinity,
      child: Column(children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Center(
          child: Text(
            'fiat_withdraw.screen.enable_2fa'.tr,
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
            "fiat_withdraw.screen.button.enable_2fa".tr,
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
}
