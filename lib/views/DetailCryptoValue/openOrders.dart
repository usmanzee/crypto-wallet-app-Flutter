import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/open_orders_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/open_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OpenOrders extends StatefulWidget {
  final Widget child;
  final FormatedMarket formatedMarket;

  OpenOrders({Key key, this.child, this.formatedMarket}) : super(key: key);

  _OpenOrdersState createState() =>
      _OpenOrdersState(formatedMarket: formatedMarket);
}

class _OpenOrdersState extends State<OpenOrders> {
  final FormatedMarket formatedMarket;
  _OpenOrdersState({this.formatedMarket});
  OpenOrdersController openOrdersController;

  @override
  void initState() {
    openOrdersController = Get.put(
      OpenOrdersController(formatedMarket: formatedMarket),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Checkbox(
                    value: openOrdersController.hideOtherOrders.value,
                    onChanged: (bool value) {
                      openOrdersController.hideOrShowOtherOrder();
                    },
                  ),
                  Text(
                    'Hide Other Pairs',
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "sans",
                        fontSize: 15.0),
                  ),
                ]),
                FlatButton(
                  height: 30.0,
                  minWidth: 40.0,
                  color: Theme.of(context).canvasColor,
                  // textColor: Colors.white,
                  child: Text(
                    "Cancel All",
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "sans",
                        fontSize: 12.0),
                  ),
                  onPressed: () {
                    cancelOrderAlert(true);
                  },
                  splashColor: Theme.of(context).canvasColor.withOpacity(0.5),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          ),
          Obx(() {
            if (openOrdersController.isLoading.value)
              return Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            else
              return _openOrdersLoaded(
                  context, openOrdersController.openOrdersSortedList.value);
          }),
        ],
      );
    });
  }

  Widget _openOrdersLoaded(BuildContext context, List<OpenOrder> openOrders) {
    return openOrders.isEmpty
        ? NoData()
        : Container(
            height: 250.0,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: openOrders.length,
              itemBuilder: (BuildContext ctx, int i) {
                return _openOrders(openOrders[i]);
              },
            ),
          );
  }

  Widget _openOrders(OpenOrder openOrder) {
    var executedVolume = double.parse(openOrder.originVolume) -
        double.parse(openOrder.remainingVolume);
    var remainingAmount = double.parse(openOrder.remainingVolume);
    var total =
        double.parse(openOrder.originVolume) * double.parse(openOrder.price);
    var filled =
        ((executedVolume / double.parse(openOrder.originVolume)) * 100);
    var priceFixed = formatedMarket.pricePrecision;
    var amountFixed = formatedMarket.amountPrecision;
    String formattedDate =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(openOrder.createdAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Container(
          child: Column(
        children: [
          Row(
            children: [
              Text(
                openOrder.side == 'buy' ? 'Buy Limit' : 'Sell Limit',
                style: TextStyle(
                    color: openOrder.side == 'buy'
                        ? Color(0xFF00C087)
                        : Colors.redAccent.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontFamily: "sans",
                    fontSize: 15.0),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  openOrder.market.toUpperCase(),
                  style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: "sans",
                      fontSize: 15.0),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                formattedDate,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "sans",
                    fontSize: 15.0),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 5.0,
                percent: filled / 100,
                center: new Text(filled.toStringAsFixed(0) + '%'),
                progressColor: openOrder.side == 'buy'
                    ? Color(0xFF00C087)
                    : Colors.redAccent.withOpacity(0.8),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.7),
                            fontFamily: "sans",
                            fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Price',
                        style: TextStyle(
                            color: Theme.of(context).hintColor.withOpacity(0.7),
                            fontFamily: "sans",
                            fontSize: 15.0),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          (executedVolume).toStringAsFixed(2),
                          style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "sans",
                              fontSize: 15.0),
                        ),
                        Text(
                          '/',
                          style: TextStyle(
                              fontFamily: "sans",
                              fontSize: 15.0,
                              color: Theme.of(context).textSelectionColor),
                        ),
                        Text(
                          double.parse(openOrder.originVolume)
                              .toStringAsFixed(2),
                          style: TextStyle(
                            fontFamily: "sans",
                            fontSize: 15.0,
                            color: Theme.of(context).hintColor.withOpacity(0.7),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        double.parse(openOrder.price)
                            .toStringAsFixed(priceFixed),
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: "sans",
                            fontSize: 15.0),
                      ),
                    ]),
              ),
              Spacer(flex: 1),
              FlatButton(
                height: 30.0,
                minWidth: 40.0,
                color: Theme.of(context).canvasColor,
                // textColor: Colors.white,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: "sans",
                      fontSize: 12.0),
                ),
                onPressed: () {
                  cancelOrderAlert(false, openOrder.id);
                },
                splashColor: Theme.of(context).canvasColor.withOpacity(0.5),
              )
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          ),
        ],
      )),
    );
  }

  void cancelOrderAlert(bool cancelAll, [int orderId]) {
    Get.dialog(AlertDialog(
      title: Text(cancelAll ? 'Cancel All Orders?' : 'Cancel Order?'),
      content: Text('You may not be able to revent this action.'),
      actions: [
        FlatButton(
          textColor: Theme.of(context).hintColor.withOpacity(0.8),
          onPressed: () {
            Get.back();
          },
          child: Text('CANCEL'),
        ),
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Get.back();
            openOrdersController.cancelOpenOrders(cancelAll, orderId);
          },
          child: Text('CONFIRM'),
        ),
      ],
    ));
  }
}
