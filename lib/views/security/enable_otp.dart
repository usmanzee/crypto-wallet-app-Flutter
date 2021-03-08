import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:crypto_template/controllers/otp_controller.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';

class EnableOTP extends GetView<OTPController> {
  final GlobalKey<FormState> _secretFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final StepperType stepperType = StepperType.vertical;

  final _otpValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'Please enter a valid 2FA code')
  ]);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        centerTitle: true,
        title: Text(
          'Two Factor Authentication',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
      ),
      body: Obx(
        () => Container(
          child: new Stepper(
            physics: ClampingScrollPhysics(),
            steps: _myStep(context),
            currentStep: controller.currentStep,
            onStepTapped: (step) {
              // setState(() {
              //   this._currentStep = step;
              // });
            },
            controlsBuilder: _createEventControlBuilder,
            onStepContinue: () {
              if (controller.currentStep < this._myStep(context).length - 1) {
                if (controller.currentStep == 2) {
                  final _formState = _secretFormKey.currentState;
                  if (_formState.validate()) {
                    _formState.save();
                    controller.currentStep = controller.currentStep + 1;
                  }
                } else {
                  controller.currentStep = controller.currentStep + 1;
                }
              } else {
                final _formState = _otpFormKey.currentState;
                if (_formState.validate()) {
                  _formState.save();
                  controller.enableOTP();
                }
              }
            },
            onStepCancel: () {
              if (controller.currentStep > 0) {
                controller.currentStep = controller.currentStep - 1;
              } else {
                controller.currentStep = 0;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: onStepCancel,
            height: 30.0,
            minWidth: 40.0,
            color: Theme.of(context).hintColor,
            child: Text(
              "Back",
              style: TextStyle(fontSize: 10),
            ),
          ),
          FlatButton(
            onPressed: onStepContinue,
            height: 30.0,
            minWidth: 40.0,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text(
              "Next",
              style: TextStyle(fontSize: 10),
            ),
          ),
        ]);
  }

  List<Step> _myStep(context) {
    List<Step> _steps = [
      Step(
          title: Text(
            'Download & Install',
            style: TextStyle(
              fontFamily: 'popins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: <Widget>[
              Text(
                'Download and install Google Authenticator application from AppStore or Google play',
                style: TextStyle(
                  fontFamily: 'popins',
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
          isActive: controller.currentStep >= 0,
          state: StepState.indexed),
      Step(
          title: Text(
            'Save The Scerect Key',
            style: TextStyle(
              fontFamily: 'popins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: <Widget>[
              Text(
                'Save this secret in a secure location. This code can be used to gain 2FA access from a different device',
                style: TextStyle(
                  fontFamily: 'popins',
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Obx(() {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: GestureDetector(
                    onTap: () {
                      Helper.copyToClipBoard(controller.secretKey.value);
                    },
                    child: Column(children: [
                      Text(
                        controller.secretKey.value,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Copy Secret',
                        style: TextStyle(
                            fontFamily: 'popins',
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
                  ),
                );
              }),
            ],
          ),
          isActive: controller.currentStep >= 1,
          state: StepState.indexed),
      Step(
          title: Text(
            'Verify The Secrect Key',
            style: TextStyle(
              fontFamily: 'popins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: <Widget>[
              // Text('Verify the secret key you saved in above step.'),
              // SizedBox(
              //   height: 8,
              // ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _secretFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) =>
                          MatchValidator(errorText: 'Key did not match')
                              .validateMatch(val, controller.secretKey.value),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText:
                              'Enter the 16-digit key you just backed up',
                          hintText: '16 digit key'),
                    ),
                  ],
                ),
              )
            ],
          ),
          isActive: controller.currentStep >= 2,
          state: StepState.indexed),
      Step(
          title: Text(
            'Submit The Code From App',
            style: TextStyle(
              fontFamily: 'popins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Now create a new entry in your authenticator app with the saved secret key and verify the gererated code.',
                style: TextStyle(
                  fontFamily: 'popins',
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _otpFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: _otpValidator,
                      controller: controller.otpTextController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          labelText: 'Enter code from google authenticator app',
                          hintText: 'Authenticator code'),
                    ),
                  ],
                ),
              )
            ],
          ),
          isActive: controller.currentStep >= 3,
          state: StepState.indexed),
    ];
    return _steps;
  }
}
