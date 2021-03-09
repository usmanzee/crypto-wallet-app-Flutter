import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/views/modals/otp_modal.dart';
import 'package:crypto_template/views/security/change_password.dart';
import 'package:crypto_template/views/security/pin_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Security extends GetView<HomeController> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        centerTitle: true,
        title: Text(
          'Security',
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
                "Enable",
                Image.asset("assets/image/google_authenticator.png",
                    height: 24.0),
                "2FA",
                Obx(
                  () => Switch(
                    value: controller.user.value.otp,
                    onChanged: (value) {
                      controller.user.value.otp
                          ? Get.to(PinCodeVerificationScreen(''))
                          // showDialog(
                          //     context: context, builder: (_) => OTPModal())
                          : Get.toNamed('/enable-otp');
                    },
                  ),
                )),
            line(context),
            InkWell(
                onTap: () {},
                child: listSetting(
                    context,
                    "Change",
                    Icon(
                      Icons.security,
                      size: 24.0,
                    ),
                    "Password",
                    FlatButton(
                      onPressed: () {
                        Get.to(ChangePassword());
                      },
                      height: 30.0,
                      minWidth: 40.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        "Change",
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
}
