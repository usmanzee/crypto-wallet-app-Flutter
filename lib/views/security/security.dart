import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/otp_controller.dart';
import 'package:crypto_template/views/security/change_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Security extends GetView<HomeController> {
  final OTPController otpController = Get.put(OTPController());
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();

  final _otpValidator = MultiValidator([
    LengthRangeValidator(
        min: 6, max: 6, errorText: 'security.screen.2fa_error'.tr)
  ]);

  void disableOTP() async {
    final _formState = _otpFormKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      otpController.disableOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        centerTitle: true,
        title: Text(
          'security.screen.title'.tr,
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
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            listSetting(
                context,
                controller.user.value.otp
                    ? "security.screen.twoFA_disable".tr
                    : "security.screen.twoFA_enable".tr,
                Image.asset("assets/image/google_authenticator.png",
                    height: 24.0),
                "security.screen.twoFA".tr,
                Obx(
                  () => Switch(
                    value: controller.user.value.otp,
                    onChanged: (value) {
                      controller.user.value.otp
                          ? showConfirmSheet(context)
                          : Get.toNamed('/enable-otp');
                    },
                  ),
                )),
            line(context),
            InkWell(
                onTap: () {},
                child: listSetting(
                    context,
                    "security.screen.password_change".tr,
                    Icon(
                      Icons.security,
                      size: 24.0,
                    ),
                    "security.screen.password".tr,
                    FlatButton(
                      onPressed: () {
                        Get.to(ChangePassword());
                      },
                      height: 30.0,
                      minWidth: 40.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        "security.screen.password_button_text".tr,
                        style: TextStyle(fontSize: 10),
                      ),
                    ))),
            line(context),
            SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget listSetting(
      context, String header, Widget icon, String title, Widget action) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Sans",
                fontSize: 13.0),
          ),
          SizedBox(
            height: 9.0,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              icon,
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: "Popins",
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Spacer(flex: 1),
              action,
            ],
          ),
          // line(context)
        ],
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

  void showConfirmSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'security.screen.disable.2fa.title'.tr,
                      style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        letterSpacing: 1.5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _otpFormKey,
                  child: Column(children: [
                    PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textStyle: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w600,
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
                        selectedColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).textSelectionColor,
                      ),
                      cursorColor: Theme.of(context).textSelectionColor,
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Theme.of(context).canvasColor,
                      controller: otpController.otpTextController,
                      autoDisposeControllers: false,
                      keyboardType: TextInputType.number,
                      validator: _otpValidator,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    )
                  ]),
                ),
                Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 8,
                      ),
                      RawMaterialButton(
                        disabledElevation: 1,
                        fillColor: Theme.of(context).primaryColor,
                        child: Center(
                            child: Text(
                          "security.screen.disable.2fa.submit".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Popins",
                              letterSpacing: 1.3,
                              fontSize: 16.0),
                        )),
                        onPressed: () {
                          disableOTP();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
