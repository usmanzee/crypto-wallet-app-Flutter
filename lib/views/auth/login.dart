import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/views/auth/forget_password.dart';
import 'package:b4u_wallet/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/controllers/login_controller.dart';

class Login extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final HomeController homeController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordValidator = MultiValidator([
    // PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
    //     errorText: 'login.screen.password.error'.tr)
    RequiredValidator(errorText: 'login.screen.password_required.error'.tr)
  ]);

  final _emailValidator = MultiValidator([
    EmailValidator(errorText: 'login.screen.email.error'.tr),
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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.clear,
            size: 24,
          ),
        ),
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        iconTheme: IconThemeData(color: Theme.of(context).hintColor),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 16.0, right: 16.0),
            child: GestureDetector(
                onTap: () {
                  Get.toNamed('/register');
                },
                child: Text(
                  'login.screen.register'.tr,
                  style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(child: Obx(() {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'login.screen.log_in'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 32.0,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
                child: Text(
                  'login.screen.field.email'.tr,
                  style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 16.0,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: CustomTextField(
                    widgetIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    validator: _emailValidator,
                    controller: _loginController.emailTextController,
                    obscure: false,
                    keyboardType: TextInputType.emailAddress,
                    hint: "login.screen.field.email_hint".tr,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
                child: Text(
                  'login.screen.field.password'.tr,
                  style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 16.0,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: CustomTextField(
                    suffix: IconButton(
                      onPressed: () {
                        _loginController.passwordVisible.value =
                            !_loginController.passwordVisible.value;
                      },
                      icon: Icon(
                        _loginController.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: _passwordValidator,
                    controller: _loginController.passwordTextController,
                    obscure:
                        _loginController.passwordVisible.value ? false : true,
                    keyboardType: TextInputType.text,
                    hint: "login.screen.field.password_hint".tr,
                    textInputAction: TextInputAction.done,
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
                          "login.screen.forget_password".tr + " ?",
                          style: TextStyle(
                            fontFamily: 'Popins',
                            color: Theme.of(context).primaryColor,
                            fontSize: 12.0,
                          ),
                        ))),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _onLoginFormSubmit();
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "login.screen.button.login".tr,
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
            ],
          ),
        );
      })),
      // floatingActionButton: FloatingActionButton(
      //     elevation: 1.0,
      //     child: Icon(
      //       Icons.east,
      //       color: Colors.white,
      //     ),
      //     backgroundColor: Theme.of(context).primaryColor,
      //     shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(10.0))),
      //     onPressed: () {
      //       FocusScope.of(context).unfocus();
      //       _onLoginFormSubmit();
      //     })
    );
  }
}
