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
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
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
    return Padding(
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
    );
  }
}
