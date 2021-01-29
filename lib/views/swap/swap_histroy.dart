import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/swap_history_controller.dart';
import 'package:crypto_template/models/swap_history_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapHistory extends GetView<SwapHistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          centerTitle: true,
          title: Text(
            'Buy/Sell History',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
          elevation: 0.8,
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 7.0, bottom: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Container(
                        // width: 100.0,
                        child: Text(
                      "From",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Container(
                        // width: 80.0,
                        child: Text(
                      "To",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.0,
            ),
            Obx(() {
              if (controller.isLoading.value)
                return Text('Loading...');
              else
                return _dataLoaded(context, controller.swapHistoryList);
            }),
          ],
        )));
  }

  Widget _dataLoaded(
      BuildContext context, List<SwapHistoryResponse> swaphistoryList) {
    return swaphistoryList.isEmpty
        ? NoData()
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: swaphistoryList.length,
              itemBuilder: (ctx, i) {
                return _withdrawHistoryList(ctx, swaphistoryList[i]);
              },
            ),
          );
  }

  Widget card(BuildContext ctx, SwapHistoryResponse swaphistoryItem) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                      //   child: Image.asset(
                      //     item.icon,
                      //     height: 22.0,
                      //     fit: BoxFit.contain,
                      //     width: 22.0,
                      //   ),
                      // ),
                      Container(
                        width: 95.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'aasd',
                                  style: TextStyle(
                                      fontFamily: "Popins", fontSize: 16.5),
                                ),
                                Text(
                                  " / " + 'dasdasd',
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontSize: 11.5,
                                      color: Theme.of(ctx).hintColor),
                                ),
                              ],
                            ),
                            Text(
                              'Vol ',
                              style: TextStyle(
                                  fontFamily: "Popins",
                                  fontSize: 11.5,
                                  color: Theme.of(ctx).hintColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'asdasdas',
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'asdasdasd',
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 11.5,
                            color: Theme.of(ctx).hintColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                      height: 25.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          color: Colors.redAccent),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          'asdasda',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
            child: Container(
              width: double.infinity,
              height: 0.5,
              decoration: BoxDecoration(color: Colors.black12),
            ),
          )
        ],
      ),
    );
  }

  Widget _withdrawHistoryList(
      BuildContext context, SwapHistoryResponse swaphistoryItem) {
    Color _color;
    IconData _icon;
    if (swaphistoryItem.status == 'canceled' ||
        swaphistoryItem.status == 'rejected' ||
        swaphistoryItem.status == 'failed' ||
        swaphistoryItem.status == 'errored') {
      _color = Colors.redAccent.withOpacity(0.75);
      _icon = Icons.close;
    } else if (swaphistoryItem.status == 'accepted' ||
        swaphistoryItem.status == 'skipped' ||
        swaphistoryItem.status == 'collected' ||
        swaphistoryItem.status == 'succeed' ||
        swaphistoryItem.status == 'confirming') {
      _color = Color(0xFF2ebd85);
      _icon = Icons.check;
    } else {
      _color = Theme.of(context).accentColor;
      _icon = Icons.autorenew;
    }
    DateTime createdAt = swaphistoryItem.createdAt;
    String formatedDate = '';
    String formatedTime = '';
    if (createdAt != null) {
      formatedDate = createdAt.year.toString() +
          '-' +
          createdAt.month.toString() +
          '-' +
          createdAt.day.toString();

      formatedTime = createdAt.hour.toString() +
          ':' +
          createdAt.minute.toString() +
          ':' +
          createdAt.second.toString();
    }
    return InkWell(
      onTap: () {
        // _withdrawHistoryDetail(context, withdrawHistoryItem, _color, _icon,
        //     formatedDate, formatedTime);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 44.0,
                  width: 44.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(70.0)),
                    border: Border.all(color: _color),
                  ),
                  child: Center(
                    child: Icon(
                      _icon,
                      color: _color,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        formatedDate,
                        style: TextStyle(
                          fontSize: 16.5,
                          letterSpacing: 1.2,
                          fontFamily: "Sans",
                        ),
                      ),
                      Text(swaphistoryItem.status,
                          style: TextStyle(
                              letterSpacing: 1.1,
                              fontFamily: "Popins",
                              fontSize: 13.0))
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  swaphistoryItem.inAmount,
                  style: TextStyle(
                      fontSize: 19.5,
                      letterSpacing: 1.6,
                      fontFamily: "Sans",
                      fontWeight: FontWeight.w600,
                      color: _color),
                ),
                Text(swaphistoryItem.inCurrencyId.toUpperCase(),
                    style: TextStyle(
                        // color: Colors.white24,
                        letterSpacing: 1.1,
                        fontFamily: "Popins",
                        fontSize: 13.0))
              ],
            ),
          ],
        ),
      ),
    );
  }
  // void _onTapItem(BuildContext context, SwapHistoryResponse notification) {
//   showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(notification.subject),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(notification.body),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           Container(
//             child: RaisedButton(
//               child: new Text(
//                 'I Understand',
//                 style: TextStyle(color: Colors.white),
//               ),
//               color: Theme.of(context).accentColor,
//               shape: new RoundedRectangleBorder(
//                 borderRadius: new BorderRadius.circular(5.0),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

  Widget historyLoaded(
      BuildContext context, List<SwapHistoryResponse> notifications) {
    return Column(
      children: <Widget>[
        Expanded(
          child: notifications.length > 0
              ? ListView.builder(
                  itemCount: notifications.length,
                  padding: const EdgeInsets.all(5.0),
                  itemBuilder: (context, i) {
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
                              '${notifications[i].inCurrencyId}',
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
                                  '${notifications[i].outAmountRequested}',
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontStyle: FontStyle.italic,
                                      color:
                                          Theme.of(context).textSelectionColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            // onTap: () =>
                            //     _onTapItem(context, notifications[i]),
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
              : NoData(),
        )
      ],
    );
  }
}
