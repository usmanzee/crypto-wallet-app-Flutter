import 'package:crypto_template/models/notification_response.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationList extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text(
          'Notifications',
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
          title: Text(notification.subject),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(notification.body),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              child: RaisedButton(
                child: new Text(
                  'I Understand',
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
        );
      },
    );
  }

  Widget noItemNotifications(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 10.0)),
            Image.asset(
              "assets/image/Template_4/notifications.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "You're up to date!",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
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
                      height: 88.0,
                      child: Column(
                        children: <Widget>[
                          Divider(
                            height: 5.0,
                            color: Colors.black12,
                          ),
                          ListTile(
                            title: Text(
                              '${notifications[position].subject}',
                              style: TextStyle(
                                  fontSize: 17.5,
                                  color: Theme.of(context).textSelectionColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Container(
                                width: 440.0,
                                child: Text(
                                  '${notifications[position].body}',
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontStyle: FontStyle.italic,
                                      color:
                                          Theme.of(context).textSelectionColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            // leading: Column(
                            //   children: <Widget>[
                            //     Container(
                            //       height: 40.0,
                            //       width: 40.0,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(60.0)),
                            //           image: DecorationImage(
                            //               image: AssetImage(
                            //                   '${items[position].image}'),
                            //               fit: BoxFit.cover)),
                            //     )
                            //   ],
                            // ),
                            onTap: () =>
                                _onTapItem(context, notifications[position]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Container(
                              width: double.infinity,
                              height: 0.5,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor),
                            ),
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
