import 'package:crypto_template/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class OTPModal extends StatelessWidget {
  final OTPController _otpController = Get.put(OTPController());
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  final _otpValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'Please enter a valid 2FA code')
  ]);

  void disableOTP() async {
    final _formState = _otpFormKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _otpController.disableOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Enter 2FA Code',
        style: TextStyle(
            fontFamily: 'Popins',
            fontSize: 16.5,
            color: Theme.of(context).textSelectionColor,
            fontWeight: FontWeight.w500),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _otpFormKey,
              child: TextFormField(
                validator: _otpValidator,
                controller: _otpController.otpTextController,
                obscureText: false,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    labelText: 'Enter code from google authenticator app',
                    hintText: 'Authenticator code'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: RaisedButton(
                child: new Text(
                  'Submit',
                  style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 14.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                color: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: RaisedButton(
                child: new Text(
                  'Cancel',
                  style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 14.5,
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w500),
                ),
                color: Theme.of(context).canvasColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
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
    //           controller: _otpController.otpTextController,
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
