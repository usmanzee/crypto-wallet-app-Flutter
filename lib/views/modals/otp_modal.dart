import 'package:crypto_template/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPModal extends StatelessWidget {
  final OTPController otpController = Get.put(OTPController());
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  final _otpValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'Please enter a valid 2FA code')
  ]);

  void disableOTP() async {
    final _formState = _otpFormKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      otpController.disableOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please Enter 2FA',
                style: TextStyle(
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
              )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _otpFormKey,
            child: Column(children: [
              TextFormField(
                validator: _otpValidator,
                controller: otpController.otpTextController,
                obscureText: false,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    labelText: 'Enter code from google authenticator app',
                    hintText: 'Authenticator code'),
              ),
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Theme.of(context).hintColor.withOpacity(0.6),
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    selectedColor: Theme.of(context).textSelectionColor,
                    activeColor: Theme.of(context).textSelectionColor),
                cursorColor: Theme.of(context).textSelectionColor,
                animationDuration: Duration(milliseconds: 300),
                controller: otpController.otpTextController,
                autoDisposeControllers: false,
                keyboardType: TextInputType.number,
                validator: _otpValidator,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              )
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                RawMaterialButton(
                  disabledElevation: 1,
                  fillColor: Theme.of(context).primaryColor,
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Popins",
                        letterSpacing: 1.3,
                        fontSize: 16.0),
                  )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.only(top: 0.0),
          //   child: RaisedButton(
          //     child: new Text(
          //       'Cancel',
          //       style: TextStyle(
          //           fontFamily: 'Popins',
          //           fontSize: 14.5,
          //           color: Theme.of(context).textSelectionColor,
          //           fontWeight: FontWeight.w500),
          //     ),
          //     color: Theme.of(context).canvasColor,
          //     shape: new RoundedRectangleBorder(
          //       borderRadius: new BorderRadius.circular(5.0),
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ),
        ],
      ),
    );
    // AlertDialog(
    //   title: Text('Enter 2FA Code'),
    //   content: Column(children: [
    //     Form(
    //       autovalidateMode: AutovalidateMode.onUserInteraction,
    //       key: _otpFormKey,
    //       child: Container(
    //         child: TextFormField(
    //           validator: _otpValidator,
    //           controller: otpController.otpTextController,
    //           obscureText: false,
    //           keyboardType: TextInputType.number,
    //           textAlign: TextAlign.start,
    //           decoration: InputDecoration(
    //               labelText: 'Enter code from google authenticator app',
    //               hintText: 'Authenticator code'),
    //         ),
    //       ),
    //     ),
    //   ]),
    //   actions: <Widget>[
    //     FlatButton(
    //       onPressed: () {
    //         disableOTP();
    //       },
    //       height: 30.0,
    //       minWidth: 60.0,
    //       color: Theme.of(context).primaryColor,
    //       textColor: Colors.white,
    //       child: Text(
    //         "Submit",
    //         style: TextStyle(
    //           fontSize: 10,
    //           fontFamily: "Popins",
    //         ),
    //       ),
    //     ),
    //     FlatButton(
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //       height: 30.0,
    //       minWidth: 40.0,
    //       color: Theme.of(context).canvasColor,
    //       child: Text(
    //         "Cancel",
    //         style: TextStyle(
    //           color: Theme.of(context).textSelectionColor,
    //           fontSize: 10,
    //           fontFamily: "Popins",
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
