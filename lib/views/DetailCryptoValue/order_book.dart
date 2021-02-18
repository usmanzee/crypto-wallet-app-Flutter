import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/order_book_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/utils/Helpers/helper.dart';

// class OrderBook extends StatefulWidget {
//   final Widget child;
//   final FormatedMarket formatedMarket;
//   final dynamic asks;
//   final dynamic bids;

//   OrderBook({Key key, this.child, this.formatedMarket, this.asks, this.bids})
//       : super(key: key);

//   _OrderBookState createState() =>
//       _OrderBookState(formatedMarket: formatedMarket, asks: asks, bids: bids);
// }

class OrderBook extends StatelessWidget {
  final bool isTrading;
  final FormatedMarket formatedMarket;
  final dynamic asks;
  final dynamic bids;

  final MarketController marketController = Get.find<MarketController>();

  OrderBook({this.isTrading, this.formatedMarket, this.asks, this.bids});
  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width / 2.2;
    return _orderBookUI(context, mediaQuery);
  }

  Widget _orderBookUI(BuildContext context, double mediaQuery) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Buy Amount",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 12,
                        fontFamily: "Popins"),
                  ),
                ),
                Text(
                  "Price",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 12,
                      fontFamily: "Popins"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Amount Sell",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontSize: 12,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Obx(() {
              if (marketController.bids.length > 0)
                return Container(
                  height: 165.0,
                  width: mediaQuery,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: marketController.bids.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return _buyAmount(
                        context,
                        mediaQuery,
                        i,
                        marketController.bids[i],
                      );
                    },
                  ),
                );
              else
                return Container(
                  height: 165.0,
                  width: mediaQuery,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext ctx, int i) {
                      return _emptyBuyAmount(mediaQuery);
                    },
                  ),
                );
            }),
            Container(
              height: 165.0,
              width: 1.0,
              color: Theme.of(context).canvasColor,
            ),
            Obx(() {
              if (marketController.asks.length > 0)
                return Container(
                  height: 165.0,
                  width: mediaQuery,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: marketController.asks.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return _amountSell(
                        context,
                        mediaQuery,
                        i,
                        marketController.asks[i],
                      );
                    },
                  ),
                );
              else
                return Container(
                  height: 165.0,
                  width: mediaQuery,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext ctx, int i) {
                      return _emptyAmountSell(mediaQuery);
                    },
                  ),
                );
            })
          ],
        )
      ],
    );
  }

  Widget _buyAmount(BuildContext context, double _width, int index, bid) {
    var rowWidth = 0.0;
    if (marketController.bids != null && marketController.bids.length > 0) {
      var resultData = Helper.mapValues(marketController.maxVolume.value,
          marketController.orderBookEntryBids.value);

      rowWidth = resultData != null && resultData.length > 0
          ? resultData[index]['value'] / 100
          : 0.0;
    }
    return Container(
      // padding: const EdgeInsets.only(bottom: 8.0),
      // color: Color(0xFF00C087).withOpacity(0.18),
      child: InkWell(
        onTap: () {
          if (isTrading) {
            final TradingController tradingController =
                Get.find<TradingController>();
            tradingController.setBidFormPrice(bid);
          }
        },
        child: Container(
          width: _width,
          height: 25,
          child: Stack(children: [
            SizedBox.expand(
              child: RotatedBox(
                quarterTurns: 0,
                child: LinearProgressIndicator(
                  value: rowWidth,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00C087).withOpacity(0.18)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    bid[1] != ''
                        ? double.parse(bid[1]).toStringAsFixed(2)
                        : double.parse('0').toStringAsFixed(2),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Gotik",
                        fontSize: 12.0),
                  ),
                ),
                Text(
                  bid[0] != ''
                      ? double.parse(bid[0]).toStringAsFixed(2)
                      : double.parse('0').toStringAsFixed(2),
                  style: TextStyle(
                      color: Color(0xFF00C087),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Gotik",
                      fontSize: 12.0),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _emptyBuyAmount(double _width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '--',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Gotik",
                    fontSize: 12.0),
              ),
            ),
            Text(
              '--',
              style: TextStyle(
                  color: Color(0xFF00C087),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _amountSell(BuildContext context, double _width, int index, ask) {
    var rowWidth = 0.0;
    if (marketController.asks != null && marketController.asks.length > 0) {
      var resultData = Helper.mapValues(marketController.maxVolume.value,
          marketController.orderBookEntryAsks.value);

      rowWidth = resultData != null && resultData.length > 0
          ? resultData[index]['value'] / 100
          : 0.0;
    }
    return Container(
      // padding: const EdgeInsets.only(bottom: 8.0),
      // color: Colors.redAccent.withOpacity(0.15),
      child: InkWell(
        onTap: () {
          if (isTrading) {
            final TradingController tradingController =
                Get.find<TradingController>();
            tradingController.setAskFormPrice(ask);
          }
        },
        child: Container(
          height: 25,
          width: _width,
          child: Stack(children: [
            SizedBox.expand(
              child: RotatedBox(
                quarterTurns: 2,
                child: LinearProgressIndicator(
                  value: rowWidth,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red.withOpacity(0.15)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ask[0] != ''
                      ? double.parse(ask[0]).toStringAsFixed(2)
                      : double.parse('0').toStringAsFixed(2),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Gotik",
                      fontSize: 12.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text(
                      ask[1] != ''
                          ? double.parse(ask[1]).toStringAsFixed(2)
                          : double.parse('0').toStringAsFixed(2),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Gotik",
                          fontSize: 12.0)),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _emptyAmountSell(double _width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '--',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 12.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '--',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Gotik",
                    fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
