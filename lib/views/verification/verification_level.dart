import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationLevel extends StatelessWidget {
  final VerificationController verificationController =
      Get.find<VerificationController>();
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'Verification',
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 0.8,
      ),
      body: Obx(() {
        if (verificationController.isLoadingLables.value ||
            homeController.fetchingUser.value ||
            homeController.fetchingMemberLevel.value)
          return Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        else
          return SingleChildScrollView(
              child: Column(
            children: [
              renderFirstLevel(context, homeController.user.value.level),
              renderSecondLevel(context, homeController.user.value.level),
              renderThirdLevel(context, homeController.user.value.level),
            ],
          ));
      }),
    );
  }

  Widget renderFirstLevel(BuildContext context, int userLevel) {
    final targetLevel = 1;
    return Card(
      child: InkWell(
          onTap: enableVerifiactionLink(userLevel, targetLevel)
              ? () {
                  Get.toNamed('/profile-verification');
                }
              : null,
          child: Container(
              padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        renderTitle(
                          context,
                          'identification.screen.email',
                          userLevel,
                          targetLevel,
                        ),
                        renderEnableText(context, targetLevel),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            renderLevelIcon(context, userLevel, targetLevel)
                          ]))
                ],
              ))),
    );
  }

  Widget renderSecondLevel(BuildContext context, int userLevel) {
    final targetLevel = 2;
    return Card(
      child: InkWell(
          onTap: enableVerifiactionLink(userLevel, targetLevel)
              ? () {
                  Get.toNamed('/profile-verification');
                }
              : null,
          child: Container(
              padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        renderTitle(
                          context,
                          'identification.screen.phone',
                          userLevel,
                          targetLevel,
                        ),
                        renderEnableText(context, targetLevel),
                      ],
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            renderLevelIcon(context, userLevel, targetLevel)
                          ]))
                ],
              ))),
    );
  }

  Widget renderThirdLevel(BuildContext context, int userLevel) {
    final targetLevel = 3;
    var isProfileSubmitted = verificationController.labelsList.firstWhere(
        (l) =>
            l.key == 'profile' &&
            l.scope == 'private' &&
            l.value == 'submitted',
        orElse: () => null);
    var isProfileRejected = verificationController.labelsList.firstWhere(
        (l) =>
            l.key == 'profile' && l.scope == 'private' && l.value == 'rejected',
        orElse: () => null);
    var isDocumentPending = verificationController.labelsList.firstWhere(
        (l) =>
            l.key == 'document' && l.scope == 'private' && l.value == 'pending',
        orElse: () => null);
    var isDocumentRejected = verificationController.labelsList.firstWhere(
        (l) =>
            l.key == 'document' &&
            l.scope == 'private' &&
            l.value == 'rejected',
        orElse: () => null);

    var isPendingLabel =
        isDocumentPending != null || isProfileSubmitted != null;
    var isRejectedLabel =
        isDocumentRejected != null || isProfileRejected != null;

    return Card(
        child: InkWell(
            onTap: enableVerifiactionLink(userLevel, targetLevel)
                ? () {
                    Get.toNamed('/profile-verification');
                  }
                : null,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          renderIdentityTitle(
                              context,
                              'identification.screen.identity',
                              userLevel,
                              targetLevel,
                              isPendingLabel),
                          renderEnableText(context, targetLevel),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            renderLevelIcon(context, userLevel, targetLevel),
                            isPendingLabel
                                ? this.renderPendingIcon(context)
                                : Container(
                                    width: 0,
                                    height: 0,
                                  ),
                            isRejectedLabel && !isPendingLabel
                                ? this.renderRejectedIcon(context)
                                : Container(
                                    width: 0,
                                    height: 0,
                                  )
                          ]),
                    )
                  ],
                ))));
  }

  Widget renderPendingIcon(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.hourglass_empty,
        color: Color.fromRGBO(224, 163, 0, 1),
      ),
      Text(
        'identification.screen.pending'.tr,
        style: TextStyle(
          color: Color.fromRGBO(224, 163, 0, 1),
        ),
      ),
    ]);
  }

  Widget renderRejectedIcon(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.clear,
        color: Colors.redAccent,
      ),
      Text(
        'identification.screen.rejected'.tr,
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
    ]);
  }

  bool enableVerifiactionLink(int userLevel, int targetLevel) {
    if (userLevel == (targetLevel - 1)) {
      return true;
    } else {
      if (userLevel < targetLevel) {
        return false;
      } else {
        return false;
      }
    }
  }

  Widget renderTitle(
      BuildContext context, String text, int userLevel, int targetLevel) {
    if (userLevel == (targetLevel - 1)) {
      return Text("${text}.unverified.title".tr,
          style: TextStyle(
              fontFamily: 'Popins',
              fontSize: 16.5,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor));
    } else {
      if (userLevel < targetLevel) {
        return Text("${text}.unverified.title".tr,
            style: TextStyle(
                fontFamily: 'Popins',
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionColor));
      } else {
        return Text("${text}.title".tr,
            style: TextStyle(
                fontFamily: 'Popins',
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionColor));
      }
    }
  }

  Widget renderIdentityTitle(BuildContext context, String text, int userLevel,
      final targetLevel, bool isPendingLabel) {
    if (verificationController.labelsList.length > 0) {
      if (userLevel == (targetLevel - 1)) {
        if (isPendingLabel) {
          return Text("${text}.unverified.title".tr,
              style: TextStyle(
                  fontFamily: 'Popins',
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textSelectionColor));
        } else {
          return Text("${text}.unverified.title".tr,
              style: TextStyle(
                  fontFamily: 'Popins',
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor));
        }
      }
      if (userLevel == targetLevel) {
        return Text("${text}.title".tr,
            style: TextStyle(
                fontFamily: 'Popins',
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionColor));
      } else {
        return Text("${text}.unverified.title".tr,
            style: TextStyle(
                fontFamily: 'Popins',
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionColor));
      }
    } else {
      return Text("${text}.unverified.title".tr,
          style: TextStyle(
              fontFamily: 'Popins',
              fontSize: 16.5,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionColor));
    }
  }

  Widget renderEnableText(BuildContext context, int userLevel) {
    int depositMinLevel =
        homeController.publicMemberLevel.value.deposit.minimumLevel;
    int withdrawMinLevel =
        homeController.publicMemberLevel.value.withdraw.minimumLevel;
    int tradingMinLevel =
        homeController.publicMemberLevel.value.trading.minimumLevel;
    String text = '';
    if (userLevel >= depositMinLevel) {
      text += 'identification.screen.deposit'.tr;
    }
    if (userLevel >= withdrawMinLevel) {
      text += ', ' + 'identification.screen.withdraw'.tr;
    }
    if (userLevel >= tradingMinLevel) {
      text += ', ' + 'identification.screen.trade'.tr;
    }
    text += " " + 'identification.screen.enabled'.tr;
    return Text(
      text,
      style:
          TextStyle(fontFamily: 'Popins', color: Theme.of(context).hintColor),
    );
  }

  Widget renderLevelIcon(
      BuildContext context, int currentLevel, int targetLevel) {
    var levelSatisfied = currentLevel >= targetLevel;
    return (levelSatisfied)
        ? Icon(
            Icons.done,
            color: Theme.of(context).textSelectionColor,
          )
        : Container(
            height: 0,
            width: 0,
          );
  }
}
