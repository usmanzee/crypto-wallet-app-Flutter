import 'package:crypto_template/component/CardDetail/AmountSell.dart';
import 'package:crypto_template/component/CardDetail/BuyAmount.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:flutter/material.dart';

class OrderBook extends StatefulWidget {
  final Widget child;
  final FormatedMarket formatedMarket;
  final dynamic asks;
  final dynamic bids;

  OrderBook({Key key, this.child, this.formatedMarket, this.asks, this.bids})
      : super(key: key);

  _OrderBookState createState() =>
      _OrderBookState(formatedMarket: formatedMarket, asks: asks, bids: bids);
}

class _OrderBookState extends State<OrderBook> {
  final FormatedMarket formatedMarket;
  final dynamic asks;
  final dynamic bids;
  _OrderBookState({this.formatedMarket, this.asks, this.bids});
  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width / 2.2;
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
                        fontFamily: "Popins"),
                  ),
                ),
                Text(
                  "Price",
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontFamily: "Popins"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "Amount Sell",
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 165.0,
              width: mediaQuery,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: bids.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return _buyAmount(mediaQuery, buyAmountList[i], bids[i]);
                },
              ),
            ),
            Container(
              height: 165.0,
              width: 1.0,
              color: Theme.of(context).canvasColor,
            ),
            Container(
              height: 165.0,
              width: mediaQuery,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: asks.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return _amountSell(mediaQuery, amountSellList[i], asks[i]);
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buyAmount(double _width, buyAmount item, bid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Container(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                double.parse(bid[0])
                    .toStringAsFixed(formatedMarket.pricePrecision),
                style: TextStyle(fontFamily: "Gotik", fontSize: 15.0),
              ),
            ),
            Text(
              double.parse(bid[0])
                  .toStringAsFixed(formatedMarket.amountPrecision),
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _amountSell(double _width, amountSell item, ask) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19.0),
      child: Container(
        width: _width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              double.parse(ask[0])
                  .toStringAsFixed(formatedMarket.pricePrecision),
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                double.parse(ask[1])
                    .toStringAsFixed(formatedMarket.amountPrecision),
                style: TextStyle(fontFamily: "Gotik", fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
