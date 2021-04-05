import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:b4u_wallet/utils/Helpers/helper.dart';

class ReferralProgram extends StatelessWidget {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    var userReferralLink = 'https://ewallet.b4uwallet.com/signup?refid=' +
        homeController.user.value.uid;
    return Scaffold(
      appBar: AppBar(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text(
          'referral.screen.title'.tr,
          style: TextStyle(
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.selectionColor),
        elevation: 1,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text('referral.screen.referral_title'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.w600,
                            fontSize: 22)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text('referral.screen.referral_description'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
              child: Text('referral.screen.referral_instruction.title'.tr,
                  style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w600,
                      fontSize: 22)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text('referral.screen.referral_instruction.description'.tr,
                  style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 12)),
            ),
            Obx(() {
              return Column(
                children: [
                  _showReferralId(context, homeController.user.value),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration:
                        BoxDecoration(color: Theme.of(context).hintColor),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  _showReferralLink(context, userReferralLink)
                ],
              );
            })
          ],
        ),
      )),
    );
  }
}

Widget _showReferralId(context, User user) {
  return Container(
    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    width: double.infinity,
    decoration: BoxDecoration(
        // color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('referral.screen.referral_id'.tr),
            Spacer(flex: 1),
            MaterialButton(
              height: 30.0,
              minWidth: 40.0,
              color: Theme.of(context).canvasColor.withOpacity(0.9),
              textColor: Theme.of(context).textSelectionTheme.selectionColor,
              child: Text(
                "referral.screen.referral_copy_id".tr,
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                Helper.copyToClipBoard(user.uid);
              },
              splashColor: Theme.of(context).canvasColor.withOpacity(0.9),
            )
          ],
        ),
        Text(
          user.uid,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).hintColor.withOpacity(0.6),
            fontSize: 12,
            fontFamily: "Popins",
          ),
        ),
      ],
    ),
  );
}

Widget _showReferralLink(context, String link) {
  return Container(
    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    width: double.infinity,
    decoration: BoxDecoration(
        // color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('referral.screen.referral_link'.tr),
            Spacer(flex: 1),
            MaterialButton(
              height: 30.0,
              minWidth: 40.0,
              color: Theme.of(context).canvasColor,
              textColor: Theme.of(context).textSelectionTheme.selectionColor,
              child: Text(
                "referral.screen.referral_copy_link".tr,
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                Helper.copyToClipBoard(link);
              },
              splashColor: Theme.of(context).canvasColor.withOpacity(0.5),
            )
          ],
        ),
        Text(
          link,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).hintColor.withOpacity(0.6),
            fontSize: 12,
            fontFamily: "Popins",
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Center(
          child: MaterialButton(
            height: 40.0,
            minWidth: 150.0,
            color: Theme.of(context).canvasColor,
            textColor: Theme.of(context).textSelectionTheme.selectionColor,
            child: new Text("referral.screen.share".tr),
            onPressed: () {
              shareLink(context, link);
            },
            splashColor: Theme.of(context).canvasColor.withOpacity(0.5),
          ),
        )
      ],
    ),
  );
}

shareLink(BuildContext context, link) {
  final RenderBox box = context.findRenderObject();
  Share.share(link,
      subject: 'B4U Wallet',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}
