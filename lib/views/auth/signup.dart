import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/views/auth/login.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/component/style.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:crypto_template/controllers/RegisterController.dart';

import 'package:form_field_validator/form_field_validator.dart';

class SignUp extends StatelessWidget {
  final ThemeBloc themeBloc;
  SignUp({this.themeBloc});

  final RegisterController _registerController = Get.put(RegisterController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'Please type a valid email'),
  ]);

  final _passwordValidator = MultiValidator([
    PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
        errorText: 'passwords must be 8 characters with uppercase letters')
  ]);

  _onSignFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _registerController.register();
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
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 17.0, top: 7.0),
                            //   child: Text(
                            //     "Crypto",
                            //     style: TextStyle(
                            //         fontFamily: "Sans",
                            //         color: Colors.white,
                            //         fontSize: 27.0,
                            //         fontWeight: FontWeight.w300,
                            //         letterSpacing: 3.5),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 32.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.email,
                              color: colorStyle.primaryColor,
                              size: 20,
                            ),
                            validator: emailValidator,
                            // onChanged: (input) => _email = input,
                            controller: _registerController.emailTextController,
                            label: 'Email',
                            obscure: false,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.vpn_key,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            validator: _passwordValidator,
                            // onChanged: (input) => _password = input,
                            controller:
                                _registerController.passwordTextController,
                            label: 'Password',
                            obscure: true,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.vpn_key,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            controller: _registerController
                                .confirmPasswordTextController,
                            validator: (val) => MatchValidator(
                                    errorText: 'passwords do not match')
                                .validateMatch(
                                    val,
                                    _registerController
                                        .passwordTextController.text),
                            // onChanged: (input) => _confirmPassword = input,
                            label: 'Confirm Password',
                            obscure: true,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 16.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.group_add,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            // onChanged: (input) => _referralCode = input,
                            controller:
                                _registerController.referralCodeController,
                            label: 'Referral Code',
                            obscure: false,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            _onSignFormSubmit();
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
                                "Register",
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 0.35,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17.5,
                                    letterSpacing: 1.9),
                              ),
                            ),
                          ),
                        ),
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

  Widget _buildTextFeild({
    String hint,
    FormFieldSetter onSaved,
    ValueChanged onChanged,
    FormFieldValidator validator,
    TextEditingController controller,
    TextInputType keyboardType,
    bool obscure,
    String icon,
    TextAlign textAlign,
    Widget widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          child: TextFormField(
            onChanged: onChanged,
            // onSaved: onSaved,
            style: new TextStyle(color: Colors.white),
            textAlign: textAlign,
            obscureText: obscure,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            autocorrect: false,
            autofocus: false,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 13.5,
                ),
                errorMaxLines: 3,
                filled: true,
                fillColor: Colors.transparent,
                labelText: hint,
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(
                  color: Colors.white70,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ],
    );
  }
}
