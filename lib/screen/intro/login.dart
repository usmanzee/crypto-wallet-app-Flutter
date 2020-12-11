import 'package:crypto_template/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:crypto_template/screen/home/home.dart';
import 'package:crypto_template/screen/intro/forget_password.dart';
import 'package:crypto_template/screen/intro/signup.dart';
import 'package:crypto_template/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/component/style.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_template/repository/auth_repository.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/component/progress_modal.dart';
import 'package:crypto_template/component/shared_pref.dart';

import 'package:crypto_template/component/flashbar/FlashBar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/LoginController.dart';

// class Login extends StatelessWidget {
//   final ThemeBloc themeBloc;
//   Login({this.themeBloc});
//   @override
//   _LoginState createState() => _LoginState(themeBloc);
// }

class Login extends StatelessWidget {
  final ThemeBloc themeBloc;
  bool _isLoading = false;
  bool isFailure = false;
  User user;
  Login({this.themeBloc});

  dynamic authObject;
  String _email, _password, _otpCode = '';
  final LoginController _loginController = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      _email = _emailController.text;
      _password = _passwordController.text;
      authObject = {
        'email': _email,
        'password': _password,
        'otp_code': _otpCode,
      };
      // authenticate(authObject);
      // _loginController.authenticate();
      // _bloc = AuthBloc(authObject);
      // _bloc.authenticate(authObject);
    }
  }

  // Future<User> authenticate(dynamic authObject) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     AuthRepository _authRepository = new AuthRepository();
  //     user = await _authRepository.authenticate(authObject);
  //     SharedPref sharedPref = SharedPref();
  //     sharedPref.saveBool('isLoggedIn', true);
  //     sharedPref.save('user', user);
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // var _storageToken = (prefs.getString('csrfToken'));
  //     // await prefs.setString('csrfToken', user.csrfToken);
  //     setState(() {
  //       _isLoading = false;
  //       isFailure = false;
  //     });
  //     Navigator.of(context).pushReplacement(PageRouteBuilder(
  //         pageBuilder: (_, __, ___) => new BottomNavBar(
  //               themeBloc: _themeBloc,
  //             )));
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isFailure = true;
  //       _isLoading = false;
  //     });
  //   }
  // }

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
        body: ProgressHUD(
          child: Container(
            height: double.infinity,
            width: double.infinity,

            /// Set Background image in splash screen layout (Click to open code)
            decoration: BoxDecoration(color: colorStyle.background),
            child: Stack(
              children: <Widget>[
                ///
                /// Set image in top
                //
                Container(
                  height: 219.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image/loginHeader.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: mediaQuery.padding.top + 130.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset("assets/image/logo.png",
                                  height: 35.0),
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
                          child: _buildTextFeild(
                              widgetIcon: Icon(
                                Icons.email,
                                color: colorStyle.primaryColor,
                                size: 20,
                              ),
                              validator: _emailValidator,
                              onChanged: (input) => _email = input,
                              controller: _emailController,
                              hint: 'Email',
                              obscure: false,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0),
                          child: _buildTextFeild(
                              widgetIcon: Icon(
                                Icons.vpn_key,
                                size: 20,
                                color: colorStyle.primaryColor,
                              ),
                              validator: _passwordValidator,
                              onChanged: (input) => _password = input,
                              controller: _passwordController,
                              hint: 'Password',
                              obscure: true,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start),
                        ),

                        ///
                        /// forgot password
                        ///
                        Padding(
                          padding: const EdgeInsets.only(right: 23.0, top: 9.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            forgetPassword(
                                              themeBloc: themeBloc,
                                            )));
                              },
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forget Password ?",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.0,
                                    ),
                                  ))),
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
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => new SignUp(
                                            themeBloc: themeBloc,
                                          )));
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 16.5,
                                      letterSpacing: 1.2),
                                ),
                              ),
                            ),
                          ),
                        ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 15.0),
//                    child: Container(width: double.infinity,height: 0.15,color: colorStyle.primaryColor,),
//                  ),
//                  Text("Register",style: TextStyle(color: colorStyle.primaryColor,fontSize: 17.0,fontWeight: FontWeight.w800),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          inAsyncCall: _isLoading,
          opacity: 0.0,
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

  // @override
  // void dispose() {
  //   _bloc.dispose();
  //   super.dispose();
  // }
}
