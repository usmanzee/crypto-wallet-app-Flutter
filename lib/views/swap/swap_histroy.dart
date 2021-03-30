import 'package:b4u_wallet/component/no_data.dart';
import 'package:b4u_wallet/controllers/swap_history_controller.dart';
import 'package:b4u_wallet/models/swap_history_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SwapHistory extends GetView<SwapHistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          centerTitle: true,
          title: Text(
            'swap_history.screen.title'.tr,
            style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontFamily: "Gotik",
                fontWeight: FontWeight.w600,
                fontSize: 18.5),
          ),
          iconTheme: IconThemeData(
              color: Theme.of(context).textSelectionTheme.selectionColor),
          elevation: 0.8,
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      // width: 100.0,
                      child: Text(
                    "swap_history.screen.column.from".tr,
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  )),
                  Container(
                      // width: 80.0,
                      child: Text(
                    "swap_history.screen.column.to".tr,
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 0.0,
            ),
            Obx(() {
              if (controller.isLoading.value)
                return Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
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
                return _swapHistoryList(ctx, swaphistoryList[i]);
              },
            ),
          );
  }

  Widget _swapHistoryList(
      BuildContext context, SwapHistoryResponse swaphistoryItem) {
    Color _color;
    IconData _icon;
    if (swaphistoryItem.status.toLowerCase() == 'canceled' ||
        swaphistoryItem.status.toLowerCase() == 'rejected' ||
        swaphistoryItem.status.toLowerCase() == 'failed' ||
        swaphistoryItem.status.toLowerCase() == 'errored') {
      _color = Colors.redAccent.withOpacity(0.75);
      _icon = Icons.close;
    } else if (swaphistoryItem.status.toLowerCase() == 'accepted' ||
        swaphistoryItem.status.toLowerCase() == 'skipped' ||
        swaphistoryItem.status.toLowerCase() == 'collected' ||
        swaphistoryItem.status.toLowerCase() == 'succeed' ||
        swaphistoryItem.status.toLowerCase() == 'confirming') {
      _color = Color(0xFF2ebd85);
      _icon = Icons.check;
    } else {
      _color = Theme.of(context).accentColor;
      _icon = Icons.autorenew;
    }
    String formatedDate =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(swaphistoryItem.createdAt);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: swaphistoryItem.outAmountRequested,
                style: TextStyle(
                  fontFamily: 'Popins',
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ' + swaphistoryItem.outCurrencyId.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 16,
                      )),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: swaphistoryItem.inAmount,
                style: TextStyle(
                  fontFamily: 'Popins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: ' ' + swaphistoryItem.inCurrencyId.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Popins',
                        fontSize: 16,
                      )),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatedDate,
                style: TextStyle(
                    fontFamily: 'Popins',
                    fontSize: 12,
                    color: Theme.of(context).hintColor)),
            Row(children: [
              Icon(
                _icon,
                size: 14,
                color: _color,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(swaphistoryItem.status,
                    style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 12,
                        color: Theme.of(context).hintColor)),
              ),
            ])
          ],
        ),
        // Divider(
        //   color: Theme.of(context).hintColor,
        // ),
      ]),
    );
  }
}
