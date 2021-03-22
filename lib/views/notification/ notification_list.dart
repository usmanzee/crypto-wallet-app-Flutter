import 'package:crypto_template/models/notification_response.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/controllers/notification_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationList extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text(
          'notifications.screen.title'.tr,
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
        if (controller.isLoading.value)
          return Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        else
          return notificationLoaded(context, controller.notificationList);
      }),
    );
  }

  void _onTapItem(BuildContext context, NotificationResponse notification) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              notification.subject,
              style: TextStyle(
                  fontFamily: 'Popins',
                  fontSize: 16.5,
                  color: Theme.of(context).textSelectionColor,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              DateFormat('yyyy-MM-dd hh:mm').format(notification.createdAt),
              style: new TextStyle(
                  letterSpacing: 1.3,
                  fontFamily: 'Popins',
                  fontSize: 13.0,
                  color: Theme.of(context).hintColor),
            ),
          ]),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  notification.body,
                  style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 14.5,
                    color: Theme.of(context).textSelectionColor,
                    // fontWeight: FontWeight.w500
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: new Text(
                      'notifications.screen.detail.seen.button.text'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget noItemNotifications(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "notifications.screen.empty.content1".tr,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.5,
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Popins"),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Center(
            child: Text(
              "notifications.screen.empty.content2".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.5,
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: "Popins"),
            ),
          ),
        ),
      ],
    );
  }

  Widget notificationLoaded(
      BuildContext context, List<NotificationResponse> notifications) {
    return Column(
      children: <Widget>[
        Expanded(
          child: notifications.length > 0
              ? ListView.builder(
                  itemCount: notifications.length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (context, position) {
                    return Container(
                      // height: 88.0,
                      child: Column(
                        children: <Widget>[
                          Divider(
                            height: 5.0,
                            color: Theme.of(context).hintColor,
                          ),
                          ListTile(
                            title: Text(
                              '${notifications[position].subject}',
                              style: TextStyle(
                                  fontFamily: 'Popins',
                                  fontSize: 16.5,
                                  color: Theme.of(context).textSelectionColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Container(
                                  width: 440.0,
                                  child: Text(
                                    '${notifications[position].body}',
                                    style: new TextStyle(
                                        fontFamily: 'Popins',
                                        fontSize: 14.0,
                                        color: Theme.of(context)
                                            .textSelectionColor
                                            .withOpacity(0.7)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  width: 440.0,
                                  child: Text(
                                    DateFormat('yyyy-MM-dd hh:mm').format(
                                        notifications[position].createdAt),
                                    style: new TextStyle(
                                        letterSpacing: 1.3,
                                        fontFamily: 'Popins',
                                        fontSize: 13.0,
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                              ),
                            ]),
                            onTap: () =>
                                _onTapItem(context, notifications[position]),
                          ),
                        ],
                      ),
                    );
                  })
              : noItemNotifications(context),
        )
      ],
    );
  }
}
