import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_template/component/style.dart';

class ChangePassword extends StatelessWidget {
  final HomeController homeController = Get.find();

  final ChangePasswordController _changePasswordController =
      Get.put(ChangePasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordValidator = MultiValidator([
    PatternValidator(r'((?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*\W)\w.{6,18}\w)',
        errorText: 'passwords must be 8 characters with uppercase letters')
  ]);

  _onSignFormSubmit() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'ChangePassword',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                        widgetIcon: Icon(
                          Icons.email,
                          color: colorStyle.primaryColor,
                          size: 20,
                        ),
                        validator: _passwordValidator,
                        controller:
                            _changePasswordController.oldPasswordTextController,
                        label: 'Old Password',
                        obscure: true,
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
                        controller:
                            _changePasswordController.passwordTextController,
                        label: 'New Password',
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
                        controller: _changePasswordController
                            .confirmPasswordTextController,
                        validator: (val) =>
                            MatchValidator(errorText: 'passwords do not match')
                                .validateMatch(
                                    val,
                                    _changePasswordController
                                        .passwordTextController.text),
                        // onChanged: (input) => _confirmPassword = input,
                        label: 'Confirm New Password',
                        obscure: true,
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
                          borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          color: colorStyle.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "Change",
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
        ),
      ),
    );
  }

  Widget line(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        decoration: BoxDecoration(color: Theme.of(context).hintColor),
      ),
    );
  }
}
