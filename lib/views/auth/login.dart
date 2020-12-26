import 'package:crypto_template/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/views/auth/forget_password.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/component/style.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/login_controller.dart';

class Login extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final HomeController homeController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordValidator = MultiValidator([
    PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
        errorText: 'passwords must be 8 characters with uppercase letters')
  ]);

  final _emailValidator = MultiValidator([
    EmailValidator(errorText: 'Please type a valid email'),
  ]);

  _onLoginFormSubmit() {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _loginController.authenticate(1);
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

          /// Set Background image in splash screen layout (Click to open code)
          // decoration: BoxDecoration(color: colorStyle.whiteBacground),
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
                            Image.asset("assets/image/b4u_wallet_logo.png",
                                height: 50.0),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 5.0, top: 0.0),
                            //   child: Text(
                            //     "B4U Wallet",
                            //     style: TextStyle(
                            //         fontFamily: "Sans",
                            //         color: colorStyle.fontColorDarkTitle,
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
                            left: 16.0, right: 16.0, top: 40.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.email,
                              color: colorStyle.primaryColor,
                              size: 20,
                            ),
                            validator: _emailValidator,
                            controller: _loginController.emailTextController,
                            label: 'Email',
                            obscure: false,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 24.0),
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.vpn_key,
                              size: 20,
                              color: colorStyle.primaryColor,
                            ),
                            validator: _passwordValidator,
                            controller: _loginController.passwordTextController,
                            label: 'Password',
                            obscure: true,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start),
                      ),

                      ///
                      /// forgot password
                      ///
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 9.0),
                        child: InkWell(
                            onTap: () {
                              Get.to(ForgetPassword());
                            },
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forget Password ?",
                                  style: TextStyle(
                                    // color: Colors.white70,
                                    fontSize: 12.0,
                                  ),
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 40.0),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/register');
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              border: Border.all(
                                color: colorStyle.primaryColor,
                                width: 0.35,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                    color: colorStyle.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.5,
                                    letterSpacing: 1.2),
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
