import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/history_controller.dart';
import 'package:crypto_template/models/trade_histroy_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TradeHistory extends StatelessWidget {
  final HistoryController historyController = Get.find();
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: historyController.refreshTradeHistory,
      child: Obx(() {
        if (historyController.isTradeHistoryLoading.value ||
            homeController.fetchingMemberLevel.value)
          return Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator());
        else
          return historyController.depositHistory.isEmpty
              ? NoData()
              : Container(
                  child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 0.0),
                  itemBuilder: (ctx, i) {
                    return _tradeHistoryList(
                      context,
                      historyController.tradeHistory[i],
                    );
                  },
                  itemCount: historyController.tradeHistory.length,
                ));
      }),
    );
  }

  Widget _tradeHistoryList(
      BuildContext context, TradeHistoryResponse tradeHistoryItem) {
    String formatedDateTime =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(tradeHistoryItem.createdAt);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              tradeHistoryItem.market.toUpperCase(),
              style: TextStyle(
                  fontSize: 18.5,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700),
            ),
            Text(
              formatedDateTime,
              style: TextStyle(
                  fontSize: 12.5,
                  fontFamily: "Popins",
                  color: Theme.of(context).hintColor,
                  letterSpacing: 1.0),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'history.screen.side'.tr,
              style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: "Popins",
                  color: Theme.of(context).hintColor),
            ),
            Text(
              tradeHistoryItem.side.toString().capitalizeFirst,
              style: TextStyle(
                  fontSize: 16.5,
                  fontFamily: "Popins",
                  color: tradeHistoryItem.side == 'sell'
                      ? Colors.redAccent
                      : Colors.greenAccent,
                  fontWeight: FontWeight.w500),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'history.screen.price'.tr,
              style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: "Popins",
                  color: Theme.of(context).hintColor),
            ),
            Text(
              tradeHistoryItem.price,
              style: TextStyle(
                  fontSize: 14.5, fontFamily: "Popins", letterSpacing: 1.0),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'history.screen.amount'.tr,
              style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: "Popins",
                  color: Theme.of(context).hintColor),
            ),
            Text(
              tradeHistoryItem.amount,
              style: TextStyle(
                  fontSize: 14.5, fontFamily: "Popins", letterSpacing: 1.0),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'history.screen.total'.tr,
              style: TextStyle(
                  fontSize: 14.5,
                  fontFamily: "Popins",
                  color: Theme.of(context).hintColor),
            ),
            Text(
              tradeHistoryItem.total,
              style: TextStyle(
                  fontSize: 14.5, fontFamily: "Popins", letterSpacing: 1.0),
            ),
          ]),
          Divider(
            color: Theme.of(context).canvasColor,
          )
        ],
      ),
    );
  }
}
