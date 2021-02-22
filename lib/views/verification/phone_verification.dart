import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PhoneVerification extends StatelessWidget {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  final GlobalKey<FormState> _pinFormKey = GlobalKey();
  final VerificationController verificationController = Get.find();

  final _pinCodeValidator = MultiValidator([
    RequiredValidator(errorText: 'Pin code is required'),
    LengthRangeValidator(
        min: 5, max: 5, errorText: 'Please enter a valid pin code')
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
                  // dropdownDecoration: BoxDecoration(
                  //   border: Border.all(color: Theme.of(context).hintColor, width: 1),
                  // ),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    // ),
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
                  child: Text('Send Verification Code'),
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
              children: [
                Center(
                  child: Text('Alert',
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
                  child: Text('A pin has been sent to your phone number',
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
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _pinFormKey,
                    child: TextFormField(
                      obscureText: false,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      validator: _pinCodeValidator,
                      controller: verificationController.pinCodeTextController,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 13.5,
                          ),
                          errorMaxLines: 3,
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Pin Code',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ),
                Obx(() {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            verificationController.codeCountDown.toString() +
                                ' Secs',
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
                            "Resend Code",
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
                  child: Text('Verify'),
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
