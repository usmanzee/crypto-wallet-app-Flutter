import 'package:crypto_template/controllers/RegisterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    var emailAddress = Get.arguments['email'];
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
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
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 17.0, top: 7.0),
                            //   child: Text(
                            //     "Crypto",
                            //     style: TextStyle(
                            //         fontFamily: "Sans",
                            //         color: Colors.white,
                            //         fontSize: 27.0,
                            //         fontWeight: FontWeight.w300,
                            //         letterSpacing: 3.5),
                            //   ),
                            // ),
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
                                        style: TextButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          controller.resendVerificationCode(
                                              emailAddress);
                                        },
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
