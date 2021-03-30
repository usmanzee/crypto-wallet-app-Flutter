import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/controllers/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TwoFA extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _twoFAValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: '2fa_login.screen.email.error'.tr)
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
    return Scaffold(
      appBar: AppBar(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.selectionColor),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      '2fa_login.screen.field.2fa'.tr,
                      style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 24.0,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 32.0),
                  child: Text(
                    "2fa_login.screen.field.2fa".tr,
                    style: TextStyle(
                      color: Theme.of(context).hintColor.withOpacity(0.7),
                      fontFamily: "Popins",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: PinCodeTextField(
                    appContext: context,
                    autoFocus: true,
                    pastedTextStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        inactiveColor:
                            Theme.of(context).hintColor.withOpacity(0.6),
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        selectedColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        activeColor: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    cursorColor:
                        Theme.of(context).textSelectionTheme.selectionColor,
                    animationDuration: Duration(milliseconds: 300),
                    controller: _loginController.twoFATextController,
                    autoDisposeControllers: false,
                    keyboardType: TextInputType.number,
                    validator: _twoFAValidator,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                    dialogConfig: DialogConfig(
                        dialogTitle: '2fa.paste_code_dialog.title'.tr,
                        dialogContent: '2fa.paste_code_dialog.content'.tr,
                        affirmativeText:
                            '2fa.paste_code_dialog.button.paste'.tr,
                        negativeText: '2fa.paste_code_dialog.button.cancel'.tr),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
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
                          "2fa_login.screen.button.login".tr,
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
      ),
    );
  }
}
