import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/views/referral_program/referral_program.dart';
import 'package:b4u_wallet/views/setting/themes.dart';
import 'package:b4u_wallet/views/webview_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:get_storage/get_storage.dart';

class Setting extends StatelessWidget {
  final HomeController homeController = Get.find();

  void _handleLogoutClick() async {
    homeController.logoutUser();
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
          'account.screen.title'.tr,
          style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.selectionColor),
        elevation: 0.8,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  if (Get.isDarkMode) {
                    Get.changeTheme(Themes.lightTheme);
                    GetStorage().write('isLightTheme', true);
                  } else {
                    GetStorage().write('isLightTheme', false);
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
                            size: 24.0,
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
                                      fontWeight: FontWeight.w600,
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
                return InkWell(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 4.0, right: 16),
                                    child: Text(
                                      'account.screen.login_register'.tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Popins",
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                              ]),
                        ]),
                  ),
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
                      size: 24.0,
                    ),
                    "account.screen.fee_schedule".tr)),
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
                            size: 24.0,
                          ),
                          "account.screen.referral_id".tr))
                  : Container();
            }),
            Obx(() {
              return (homeController.isLoggedIn.value)
                  ? InkWell(
                      onTap: () {
                        Get.toNamed('/verification-level');
                      },
                      child: listSetting(
                          context,
                          Icon(
                            Icons.perm_identity,
                            size: 24.0,
                          ),
                          "account.screen.identification".tr))
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
                            size: 24.0,
                          ),
                          "account.screen.notifications".tr))
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
                            size: 24.0,
                          ),
                          "account.screen.security".tr))
                  : Container();
            }),
            InkWell(
                onTap: () {
                  showLanguages(context);
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.language,
                      size: 24.0,
                    ),
                    "account.screen.languages".tr)),
            InkWell(
                onTap: () {
                  Get.to(WebViewContainer('Help/Support',
                      'https://support.b4uwallet.com/lhc/lhc_web/index.php/chat/start'));
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.live_help,
                      size: 24.0,
                    ),
                    "account.screen.help_support".tr)),
            InkWell(
                onTap: () {
                  share(context);
                },
                child: listSetting(
                    context,
                    Icon(
                      Icons.share,
                      size: 24.0,
                    ),
                    "account.screen.share".tr)),
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
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "account.screen.logout".tr,
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
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
              child: Text('account.screen.instructions'.tr,
                  style: TextStyle(
                    fontFamily: "Popins",
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  )),
            ),
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
            height: 16.0,
          ),
          Row(
            children: <Widget>[
              icon,
              SizedBox(
                width: 16,
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
              Icon(
                Icons.keyboard_arrow_right,
                size: 24.0,
                color: Theme.of(context).hintColor,
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          line(context)
        ],
      ),
    );
  }

  Widget line(context) {
    return Container(
      width: double.infinity,
      height: 0.5,
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
    );
  }

  void showLanguages(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Choose Language',
              style: TextStyle(fontFamily: 'Popins'),
            ),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    GetStorage().write('lang_code',
                        homeController.languages[index]['lang_code']);
                    GetStorage().write('country_code',
                        homeController.languages[index]['country_code']);
                    Get.updateLocale(Locale(
                        homeController.languages[index]['lang_code'],
                        homeController.languages[index]['country_code']));
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            homeController.languages[index]['name'],
                            style: TextStyle(fontFamily: 'Popins'),
                          ),
                          if (Get.locale ==
                              Locale(
                                  homeController.languages[index]['lang_code'],
                                  homeController.languages[index]
                                      ['country_code']))
                            Icon(
                              Icons.done,
                              size: 24.0,
                              color: Theme.of(context).accentColor,
                            ),
                        ]),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: homeController.languages.length,
              ),
            ),
          );
        });
  }
}
