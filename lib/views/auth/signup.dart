import 'package:b4u_wallet/views/webview_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/component/custom_text_field.dart';
import 'package:b4u_wallet/controllers/RegisterController.dart';

import 'package:form_field_validator/form_field_validator.dart';

class SignUp extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

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
      registerController.register();
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
                    Get.back();
                  },
                  child: Text(
                    'register.screen.login'.tr,
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
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      'register.screen.register'.tr,
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
                    'register.screen.field.email'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 16.0,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
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
                      validator: emailValidator,
                      controller: registerController.emailTextController,
                      obscure: false,
                      keyboardType: TextInputType.emailAddress,
                      hint: "register.screen.field.email_hint".tr,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    'register.screen.field.password'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 16.0,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
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
                        Icons.vpn_key,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      validator: _passwordValidator,
                      controller: registerController.passwordTextController,
                      obscure: true,
                      keyboardType: TextInputType.text,
                      hint: "register.screen.field.password_hint".tr,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    'register.screen.field.confirm_password'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 16.0,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
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
                        Icons.vpn_key,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      controller:
                          registerController.confirmPasswordTextController,
                      validator: (val) => MatchValidator(
                              errorText:
                                  'register.screen.confirm_password.error'.tr)
                          .validateMatch(val,
                              registerController.passwordTextController.text),
                      obscure: true,
                      keyboardType: TextInputType.text,
                      hint: "register.screen.field.confirm_password_hint".tr,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    'register.screen.field.referral_id'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 16.0,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
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
                        Icons.group_add,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      controller: registerController.referralCodeController,
                      obscure: false,
                      keyboardType: TextInputType.text,
                      hint: "register.screen.field.referral_id_hint".tr,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start),
                ),
                Obx(() {
                  return Row(children: [
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: registerController.termsOfUse.value,
                      onChanged: (bool value) {
                        registerController.termsOfUse.value =
                            !registerController.termsOfUse.value;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        registerController.termsOfUse.value =
                            !registerController.termsOfUse.value;
                      },
                      child: Text(
                        "register.screen.field.agree".tr,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontFamily: "Popins",
                            fontSize: 12.0),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(WebViewContainer('Terms and Conditions',
                            'https://b4uwallet.com/terms-and-conditions/'));
                      },
                      child: Text(
                        "register.screen.field.terms".tr,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "Popins",
                            fontSize: 14.0),
                      ),
                    ),
                  ]);
                }),
                Obx(() {
                  if (!registerController.termsOfUse.value)
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: Text(
                        'register.screen.field.terms.error'.tr,
                        style: TextStyle(
                          fontFamily: 'Popins',
                          fontSize: 12.0,
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    );
                  else
                    return Container(
                      width: 0,
                      height: 0,
                    );
                })
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 1.0,
            child: Icon(
              Icons.east,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _onSignFormSubmit();
            }));
  }
}
