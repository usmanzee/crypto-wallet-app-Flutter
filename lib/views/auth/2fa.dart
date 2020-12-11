import 'package:flutter/material.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/component/style.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/LoginController.dart';

class TwoFA extends StatelessWidget {
  final ThemeBloc themeBloc;
  TwoFA({this.themeBloc});

  final LoginController _loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _twoFAValidator = MultiValidator([
    // RequiredValidator(errorText: 'password is required'),
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
      autovalidate: true,
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,

          /// Set Background image in splash screen layout (Click to open code)
          decoration: BoxDecoration(color: colorStyle.background),
          child: Stack(
            children: <Widget>[
              ///
              /// Set image in top
              //
              // Container(
              //   height: 219.0,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage("assets/image/loginHeader.png"),
              //           fit: BoxFit.cover)),
              // ),
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
                            Image.asset("assets/image/logo.png", height: 35.0),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 17.0, top: 7.0),
                              child: Text(
                                "Crypto",
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.white,
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 3.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 80.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.email,
                              color: colorStyle.primaryColor,
                              size: 20,
                            ),
                            validator: _twoFAValidator,
                            controller: _loginController.twoFATextController,
                            label: 'Enter 2FA code',
                            hint: '2FA code',
                            obscure: false,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            _onLoginFormSubmit();
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              color: colorStyle.primaryColor,
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
