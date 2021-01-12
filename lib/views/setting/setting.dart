import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/views/notification/%20notification_list.dart';
import 'package:crypto_template/views/referral_program/referral_program.dart';
import 'package:crypto_template/views/security/security.dart';
// import 'package:crypto_template/views/setting/SeeAllTemplate.dart';
import 'package:crypto_template/views/setting/themes.dart';
import 'package:crypto_template/views/webview_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/component/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

class Setting extends StatelessWidget {
  final HomeController homeController = Get.find();
  final ThemeBloc themeBloc;
  Setting({Key key, this.themeBloc}) : super(key: key);
  final bool theme = true;
  // String _img = "assets/image/setting/lightMode.png";

  void _handleLogoutClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedIn');
    homeController.isLoggedIn = false;
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
        brightness: Brightness.dark,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(top: 40.0),
            //   child: Center(
            //       child: Text(
            //     "Settings",
            //     style: TextStyle(
            //         fontFamily: "Sans",
            //         fontSize: 19.5,
            //         fontWeight: FontWeight.w700),
            //   )),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),

            ///
            /// Image header
            ///
            // InkWell(
            //   onTap: () {
            //     ///
            //     /// Change image header and theme color if user click image
            //     ///
            //     if (theme == true) {
            //       setState(() {
            //         _img = "assets/image/setting/nightMode.png";
            //         theme = false;
            //       });
            //       themeBloc.selectedTheme.add(_buildLightTheme());
            //     } else {
            //       themeBloc.selectedTheme.add(_buildDarkTheme());
            //       setState(() {
            //         theme = true;
            //         _img = "assets/image/setting/lightMode.png";
            //       });
            //     }
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            //     child: Container(
            //       height: 125.0,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //           image: DecorationImage(
            //               image: AssetImage(_img), fit: BoxFit.cover)),
            //     ),
            //   ),
            // ),
            Obx(() {
              if (homeController.isLoggedIn) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: 32.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            ? 'ID: ' +
                                                homeController.user.value.uid
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
                  Get.to(WebViewContainer('https://ewallet.b4uwallet.com/fee'));
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.event_note,
                      size: 20.0,
                    ),
                    "Fee Schedule")),
            Obx(() {
              return (homeController.isLoggedIn)
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
              return (homeController.isLoggedIn)
                  ? InkWell(
                      onTap: () {
                        Get.off(NotificationList());
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
              return (homeController.isLoggedIn)
                  ? InkWell(
                      onTap: () {
                        Get.to(Security());
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
                  // Get.to(Security());
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
              if (homeController.isLoggedIn)
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      _handleLogoutClick();
                    },
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        border: Border.all(
                          color: colorStyle.primaryColor,
                          width: 0.35,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: colorStyle.primaryColor,
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

  ///
  /// Change to mode light theme
  ///
  DemoTheme _buildLightTheme() {
    return DemoTheme(
        'light',
        ThemeData(
          brightness: Brightness.light,
          accentColor: colorStyle.primaryColor,
          primaryColor: colorStyle.primaryColor,
          buttonColor: colorStyle.primaryColor,
          cardColor: colorStyle.cardColorLight,
          textSelectionColor: colorStyle.fontColorLight,
          scaffoldBackgroundColor: Color(0xFFFDFDFD),
          canvasColor: colorStyle.whiteBacground,
          dividerColor: colorStyle.iconColorLight,
          hintColor: colorStyle.fontSecondaryColorLight,
        ));
  }

  ///
  /// Change to mode dark theme
  ///
  DemoTheme _buildDarkTheme() {
    return DemoTheme(
        'dark',
        ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: colorStyle.background,
            backgroundColor: colorStyle.blackBackground,
            dividerColor: colorStyle.iconColorDark,
            accentColor: colorStyle.primaryColor,
            primaryColor: colorStyle.primaryColor,
            hintColor: colorStyle.fontSecondaryColorDark,
            buttonColor: colorStyle.primaryColor,
            canvasColor: colorStyle.grayBackground,
            cardColor: colorStyle.grayBackground,
            textSelectionColor: colorStyle.fontColorDark,
            textSelectionHandleColor: colorStyle.fontColorDarkTitle));
  }
}
