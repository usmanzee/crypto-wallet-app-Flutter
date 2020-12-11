import 'package:flutter/material.dart';
import 'package:crypto_template/component/style.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:crypto_template/component/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/LoginController.dart';

class EmailVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,

          /// Set Background image in splash screen layout (Click to open code)
          decoration: BoxDecoration(color: colorStyle.background),
          child: Stack(
            children: <Widget>[
              ///
              /// Set image in top
              //
              // Container(
              //   height: 219.0,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage("assets/image/loginHeader.png"),
              //           fit: BoxFit.cover)),
              // ),
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
                            Image.asset("assets/image/logo.png", height: 35.0),
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
                            left: 20.0, right: 20.0, top: 50.0),
                        child: Center(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ListTile(
                                    title: Text(
                                      'Verify Your Email Address',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                                      child: Text(
                                          'To complete registration, check for an email in your inbox with further instruction. If you cannot find the email, please check your spam folder.'),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        child:
                                            const Text('Resend Confirmation'),
                                        onPressed: () {/* ... */},
                                      ),
                                    ],
                                  ),
                                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
