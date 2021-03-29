import 'package:b4u_wallet/controllers/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/component/custom_text_field.dart';
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
                  'forget_password.screen.login'.tr,
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
                    'forget_password.screen.reset_password'.tr,
                    style: TextStyle(
                      fontFamily: 'Popins',
                      fontSize: 32.0,
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                child: Text(
                  'forget_password.screen.field.email'.tr,
                  style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 16.0,
                    color: Theme.of(context).textSelectionColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: CustomTextField(
                    widgetIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    validator: _emailValidator,
                    controller: _forgetPasswordController.emailTextController,
                    hint: 'forget_password.screen.field.email_hint'.tr,
                    obscure: false,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _handleSendVerificationFormSubmit(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
