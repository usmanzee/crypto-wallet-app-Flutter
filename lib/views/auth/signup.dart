import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:crypto_template/controllers/RegisterController.dart';

import 'package:form_field_validator/form_field_validator.dart';

class SignUp extends StatelessWidget {
  final ThemeBloc themeBloc;
  SignUp({this.themeBloc});

  final RegisterController _registerController = Get.put(RegisterController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'register.screen.email.error'.tr),
  ]);

  final _passwordValidator = MultiValidator([
    PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
        errorText: 'register.screen.password.error'.tr)
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
                            left: 16.0, right: 16.0, top: 32.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            validator: emailValidator,
                            // onChanged: (input) => _email = input,
                            controller: _registerController.emailTextController,
                            label: 'register.screen.field.email'.tr,
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
                              color: Theme.of(context).primaryColor,
                            ),
                            validator: _passwordValidator,
                            // onChanged: (input) => _password = input,
                            controller:
                                _registerController.passwordTextController,
                            label: 'register.screen.field.password'.tr,
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
                              color: Theme.of(context).primaryColor,
                            ),
                            controller: _registerController
                                .confirmPasswordTextController,
                            validator: (val) => MatchValidator(
                                    errorText:
                                        'register.screen.confirm_password.error'
                                            .tr)
                                .validateMatch(
                                    val,
                                    _registerController
                                        .passwordTextController.text),
                            // onChanged: (input) => _confirmPassword = input,
                            label: 'register.screen.field.confirm_password'.tr,
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
                              color: Theme.of(context).primaryColor,
                            ),
                            // onChanged: (input) => _referralCode = input,
                            controller:
                                _registerController.referralCodeController,
                            label: 'register.screen.field.referral_code'.tr,
                            obscure: false,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                                "register.screen.button.register".tr,
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
                                "register.screen.button.login".tr,
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
}
