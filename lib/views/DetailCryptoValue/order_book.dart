import 'package:crypto_template/component/CardDetail/AmountSell.dart';
import 'package:crypto_template/component/CardDetail/BuyAmount.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/order_book_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      return _buyAmount(mediaQuery, marketController.bids[i]);
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
                      return _amountSell(mediaQuery, marketController.asks[i]);
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

  Widget _buyAmount(double _width, bid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: _width,
        child: GestureDetector(
          onTap: () {
            if (isTrading) {
              final TradingController tradingController =
                  Get.find<TradingController>();
              tradingController.setBidFormPrice(bid);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  double.parse(bid[1])
                      .toStringAsFixed(formatedMarket.amountPrecision),
                  style: TextStyle(fontFamily: "Gotik", fontSize: 12.0),
                ),
              ),
              Text(
                double.parse(bid[0])
                    .toStringAsFixed(formatedMarket.pricePrecision),
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Gotik",
                    fontSize: 12.0),
              )
            ],
          ),
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
                style: TextStyle(fontFamily: "Gotik", fontSize: 12.0),
              ),
            ),
            Text(
              '--',
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Gotik",
                  fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _amountSell(double _width, ask) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: _width,
        child: GestureDetector(
          onTap: () {
            if (isTrading) {
              final TradingController tradingController =
                  Get.find<TradingController>();
              tradingController.setAskFormPrice(ask);
            }
          },
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
                    fontSize: 12.0),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  double.parse(ask[1])
                      .toStringAsFixed(formatedMarket.amountPrecision),
                  style: TextStyle(fontFamily: "Gotik", fontSize: 12.0),
                ),
              ),
            ],
          ),
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
                style: TextStyle(fontFamily: "Gotik", fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
