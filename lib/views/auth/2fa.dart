import 'package:flutter/material.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TwoFA extends StatelessWidget {
  final ThemeBloc themeBloc;
  TwoFA({this.themeBloc});

  final LoginController _loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _twoFAValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'Please enter a valid 2FA code')
  ]);

  _onLoginFormSubmit() {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _loginController.authenticate(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: mediaQuery.padding.top + 80.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/image/b4u_wallet_logo.png",
                                height: 50.0),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 40.0),
                          child: PinCodeTextField(
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
                                inactiveColor: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.6),
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                selectedColor:
                                    Theme.of(context).textSelectionColor,
                                activeColor:
                                    Theme.of(context).textSelectionColor),
                            cursorColor: Theme.of(context).textSelectionColor,
                            animationDuration: Duration(milliseconds: 300),
                            controller: _loginController.twoFATextController,
                            autoDisposeControllers: false,
                            keyboardType: TextInputType.number,
                            validator: _twoFAValidator,
                            onCompleted: (v) {},
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              return true;
                            },
                          )
                          // CustomTextField(
                          //     widgetIcon: Icon(
                          //       Icons.email,
                          //       color: Theme.of(context).primaryColor,
                          //       size: 20,
                          //     ),
                          //     validator: _twoFAValidator,
                          //     controller: _loginController.twoFATextController,
                          //     label: 'Enter 2FA code',
                          //     // hint: '2FA code',
                          //     obscure: false,
                          //     keyboardType: TextInputType.number,
                          //     textAlign: TextAlign.start),
                          ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _onLoginFormSubmit();
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    letterSpacing: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
