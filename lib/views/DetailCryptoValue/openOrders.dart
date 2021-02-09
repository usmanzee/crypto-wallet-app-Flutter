import 'package:crypto_template/component/no_data.dart';
import 'package:crypto_template/controllers/open_orders_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/models/open_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        tag: 'open_orders_instance');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 7.0, bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Date",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
                Text(
                  "Price(${formatedMarket.quoteUnit.toUpperCase()})",
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontFamily: "Popins"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Amount(${formatedMarket.baseUnit.toUpperCase()})",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Value",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Filled",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
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
                context, openOrdersController.openOrdersList.value);
        }),
      ],
    );
  }

  Widget _openOrdersLoaded(BuildContext context, List<OpenOrder> openOrders) {
    return openOrders.isEmpty
        ? NoData()
        : Container(
            height: 150.0,
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
    String formattedDate = DateFormat('MM-dd').format(openOrder.createdAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                formattedDate,
                style: TextStyle(
                    color:
                        Theme.of(context).textSelectionColor.withOpacity(0.7),
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
            ),
            Text(
              (double.parse(openOrder.price)).toStringAsFixed(priceFixed),
              style: TextStyle(
                fontFamily: "Gotik",
                fontSize: 15.0,
                color: openOrder.side == 'buy'
                    ? Color(0xFF00C087)
                    : Colors.redAccent.withOpacity(0.8),
              ),
            ),
            Text(
              remainingAmount.toStringAsFixed(amountFixed),
              style: TextStyle(
                  color: openOrder.side == 'buy'
                      ? Color(0xFF00C087)
                      : Colors.redAccent.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 15.0),
            ),
            Text(
              total.toStringAsFixed(amountFixed),
              style: TextStyle(
                  color: openOrder.side == 'buy'
                      ? Color(0xFF00C087)
                      : Colors.redAccent.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(
                filled.toString(),
                style: TextStyle(
                    color: openOrder.side == 'buy'
                        ? Color(0xFF00C087)
                        : Colors.redAccent.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
