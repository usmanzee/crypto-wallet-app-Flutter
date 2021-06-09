import 'package:b4u_wallet/controllers/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChangePassword extends StatelessWidget {
  final ChangePasswordController _changePasswordController =
      Get.put(ChangePasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordValidator = MultiValidator([
    PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
        errorText: 'change.password.screen.password.error'.tr)
  ]);

  _handleFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _changePasswordController.changePassword();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        centerTitle: true,
        title: Text(
          'change.password.screen.title'.tr,
          style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.selectionColor),
        elevation: 0.8,
      ),
      body: SingleChildScrollView(child: Obx(() {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 32.0),
                    child: CustomTextField(
                        suffix: IconButton(
                          onPressed: () {
                            _changePasswordController.passwordVisible.value =
                                !_changePasswordController
                                    .passwordVisible.value;
                          },
                          icon: Icon(
                            _changePasswordController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        validator: _passwordValidator,
                        controller:
                            _changePasswordController.oldPasswordTextController,
                        label: 'change.password.screen.field.old_password'.tr,
                        obscure: _changePasswordController.passwordVisible.value
                            ? false
                            : true,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        suffix: IconButton(
                          onPressed: () {
                            _changePasswordController.passwordVisible.value =
                                !_changePasswordController
                                    .passwordVisible.value;
                          },
                          icon: Icon(
                            _changePasswordController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        validator: _passwordValidator,
                        controller:
                            _changePasswordController.passwordTextController,
                        label: 'change.password.screen.field.new_password'.tr,
                        obscure: _changePasswordController.passwordVisible.value
                            ? false
                            : true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: CustomTextField(
                        suffix: IconButton(
                          onPressed: () {
                            _changePasswordController.passwordVisible.value =
                                !_changePasswordController
                                    .passwordVisible.value;
                          },
                          icon: Icon(
                            _changePasswordController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        controller: _changePasswordController
                            .confirmPasswordTextController,
                        validator: (val) => MatchValidator(
                                errorText:
                                    'change.password.screen.password_confirm.error'
                                        .tr)
                            .validateMatch(
                                val,
                                _changePasswordController
                                    .passwordTextController.text),
                        label:
                            'change.password.screen.field.confirm_new_password'
                                .tr,
                        obscure: _changePasswordController.passwordVisible.value
                            ? false
                            : true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 40.0),
                    child: GestureDetector(
                      onTap: () {
                        _handleFormSubmit();
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
                            "change.password.screen.change".tr,
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
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        );
      })),
    );
  }
}
