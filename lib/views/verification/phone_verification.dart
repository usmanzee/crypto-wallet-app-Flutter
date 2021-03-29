import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:b4u_wallet/controllers/verification_controller.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerification extends StatelessWidget {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  final GlobalKey<FormState> _pinFormKey = GlobalKey();
  final VerificationController verificationController = Get.find();

  final _phoneValidator = MultiValidator([
    LengthRangeValidator(
        min: 10,
        max: 10,
        errorText: 'identification.screen.phone.phone.error'.tr)
  ]);

  final _pinCodeValidator = MultiValidator([
    LengthRangeValidator(
        min: 5, max: 5, errorText: 'identification.screen.phone.pin.error'.tr)
  ]);
  void sendPhoneVerificationCode() {
    final _formState = _phoneFormKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      verificationController.sendPhoneVerificationCode();
    }
  }

  void verifyPhonePinCode() {
    final _formState = _pinFormKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      verificationController.verifyPhonePinCode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          if (!verificationController.codeSent)
            Form(
              key: _phoneFormKey,
              child: Column(children: [
                IntlPhoneField(
                  controller: verificationController.phoneTextController,
                  autoValidate: false,
                  validator: _phoneValidator,
                  searchText:
                      'identification.screen.phone.field.search.country'.tr,
                  decoration: InputDecoration(
                    labelText: 'identification.screen.phone.field.phone'.tr,
                  ),
                  initialCountryCode: 'PK',
                  onChanged: (phone) {
                    verificationController.phoneNumberText.value =
                        phone.completeNumber;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  child: Text(
                    'identification.screen.phone.button.send_code'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    sendPhoneVerificationCode();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('identification.screen.phone.alert'.tr,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Popins",
                          letterSpacing: 1.3,
                          fontSize: 16.0)),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text('identification.screen.phone.alert.desc'.tr,
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          letterSpacing: 1.3,
                          fontSize: 14.0)),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(verificationController.phoneNumberText.value,
                      // verificationController.phoneTextController.text,
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Popins",
                          fontSize: 20.0)),
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Edit phone number',
                    onPressed: () {
                      verificationController.codeSent = false;
                    },
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'identification.screen.phone.field.pin'.tr,
                    style: TextStyle(
                      color: Theme.of(context).hintColor.withOpacity(0.7),
                      fontFamily: "Popins",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _pinFormKey,
                      child: PinCodeTextField(
                        appContext: context,
                        autoFocus: true,
                        pastedTextStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textStyle: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.w600,
                        ),
                        length: 5,
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
                          activeColor: Theme.of(context).textSelectionColor,
                        ),
                        cursorColor: Theme.of(context).textSelectionColor,
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        controller:
                            verificationController.pinCodeTextController,
                        autoDisposeControllers: false,
                        keyboardType: TextInputType.number,
                        validator: _pinCodeValidator,
                        onCompleted: (v) {},
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          return true;
                        },
                        dialogConfig: DialogConfig(
                            dialogTitle: '2fa.paste_code_dialog.title'.tr,
                            dialogContent: '2fa.paste_code_dialog.content'.tr,
                            affirmativeText:
                                '2fa.paste_code_dialog.button.paste'.tr,
                            negativeText:
                                '2fa.paste_code_dialog.button.cancel'.tr),
                      )),
                ),
                Obx(() {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            verificationController.codeCountDown.toString() +
                                ' ' +
                                'identification.screen.phone.secs'.tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Popins",
                                letterSpacing: 1.3,
                                fontSize: 16.0)),
                        FlatButton(
                          height: 32.0,
                          minWidth: 120.0,
                          textColor: Theme.of(context).accentColor,
                          child: Text(
                            "identification.screen.phone.button.resend".tr,
                            style: TextStyle(fontSize: 12),
                          ),
                          onPressed: () {
                            if (verificationController.codeCountDown == 0) {
                              verificationController
                                  .reSendPhoneVerificationCode();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(5)),
                          splashColor:
                              Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                      ]);
                }),
                MaterialButton(
                  minWidth: double.infinity,
                  child: Text('identification.screen.phone.button.verify'.tr),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    verifyPhonePinCode();
                  },
                ),
              ],
            )
        ],
      );
    });
  }
}
