import 'package:crypto_template/controllers/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  final ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailValidator = MultiValidator([
    EmailValidator(errorText: 'forget_password.screen.email.error'.tr),
  ]);

  _handleSendVerificationFormSubmit(context) {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _forgetPasswordController.sendPasswordResetLink();
      FocusScope.of(context).requestFocus(null);
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
                        child: CustomTextField(
                            widgetIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            validator: _emailValidator,
                            controller:
                                _forgetPasswordController.emailTextController,
                            label: 'forget_password.screen.field.email'.tr,
                            obscure: false,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _handleSendVerificationFormSubmit(context);
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
                                "forget_password.screen.button.send_code".tr,
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
                                "forget_password.screen.button.login".tr,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
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
