import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/views/referral_program/referral_program.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/views/webview_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

class Setting extends StatelessWidget {
  final HomeController homeController = Get.find();

  void _handleLogoutClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedIn');
    homeController.isLoggedIn.value = false;
    Get.back();
  }

  void share(BuildContext context) {
    final _shareLink = 'Play store link';
    final RenderBox box = context.findRenderObject();
    Share.share(_shareLink,
        subject: 'B4U Wallet',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        centerTitle: true,
        title: Text(
          'Account',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (Get.isDarkMode) {
                    Get.changeTheme(Themes.lightTheme);
                  } else {
                    Get.changeTheme(Themes.darkTheme);
                  }
                },
                child: Icon(
                  Get.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(WebViewContainer('Help/Support',
                      'https://support.b4uwallet.com/lhc/lhc_web/index.php/chat/start'));
                },
                child: Icon(Icons.support_agent),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Obx(() {
              if (homeController.isLoggedIn.value) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.account_circle,
                            size: 32.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    homeController.user.value.email != null
                                        ? homeController.user.value.email
                                        : '---',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Popins",
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  Text(
                                    homeController.user.value.uid != null
                                        ? 'ID: ' + homeController.user.value.uid
                                        : '---',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: "Popins",
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                      ]),
                );
              } else {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  size: 32.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Login/Register',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Popins",
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                                Spacer(flex: 1),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                              ]),
                        ),
                      ]),
                );
              }
            }),
            InkWell(
                onTap: () {
                  Get.to(WebViewContainer(
                      'Fee', 'https://ewallet.b4uwallet.com/fee'));
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.event_note,
                      size: 20.0,
                    ),
                    "Fee Schedule")),
            Obx(() {
              return (homeController.isLoggedIn.value)
                  ? InkWell(
                      onTap: () {
                        Get.to(ReferralProgram());
                      },
                      child: listSetting(
                          context,
                          Icon(
                            Icons.group_add,
                            size: 20.0,
                          ),
                          "Referral ID"))
                  : Container();
            }),
            Obx(() {
              return (homeController.isLoggedIn.value)
                  ? InkWell(
                      onTap: () {
                        Get.toNamed('/profile-verification');
                      },
                      child: listSetting(
                          context,
                          Icon(
                            Icons.group_add,
                            size: 20.0,
                          ),
                          "Identification"))
                  : Container();
            }),
            Obx(() {
              return (homeController.isLoggedIn.value)
                  ? InkWell(
                      onTap: () {
                        Get.toNamed('/notifications');
                      },
                      child: listSetting(
                          context,
                          Icon(
                            Icons.notifications_active,
                            size: 20.0,
                          ),
                          "Notifications"))
                  : Container();
            }),
            Obx(() {
              return (homeController.isLoggedIn.value)
                  ? InkWell(
                      onTap: () {
                        Get.toNamed('/security');
                      },
                      child: listSetting(
                          context,
                          Icon(
                            Icons.security,
                            size: 20.0,
                          ),
                          "Security"))
                  : Container();
            }),
            InkWell(
                onTap: () {
                  Get.to(WebViewContainer('Help/Support',
                      'https://support.b4uwallet.com/lhc/lhc_web/index.php/chat/start'));
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.live_help,
                      size: 20.0,
                    ),
                    "Help & Support")),
            InkWell(
                onTap: () {
                  share(context);
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.share,
                      size: 20.0,
                    ),
                    "Share The App")),
            SizedBox(
              height: 16.0,
            ),
            Obx(() {
              if (homeController.isLoggedIn.value)
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: InkWell(
                    onTap: () {
                      _handleLogoutClick();
                    },
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 0.35,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.5,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ),
                );
              else
                return Container();
            }),
            SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget listSetting(context, Widget icon, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            children: <Widget>[
              icon,
              SizedBox(
                width: 12,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Popins",
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          line(context)
        ],
      ),
    );
  }

  Widget line(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        decoration: BoxDecoration(color: Theme.of(context).hintColor),
      ),
    );
  }
}
