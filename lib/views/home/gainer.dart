import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/views/home/markets_loading_animation.dart';
import 'package:crypto_template/views/home/empty_markets.dart';

class Gainer extends StatelessWidget {
  final Widget child;

  Gainer({Key key, this.child}) : super(key: key);

  final MarketController marketController = Get.find();

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
                  child: Container(
                      width: 100.0,
                      child: Text(
                        "Pair",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins"),
                      )),
                ),
                Container(
                    width: 100.0,
                    child: Text(
                      "Last Price",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
                Container(
                    width: 80.0,
                    child: Text(
                      "24h Chg%",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
              ],
            ),
          ),
        ),

        ///
        /// check the condition if markets data from server loaded or not
        ///

        Obx(() {
          if (marketController.isLoading.value)
            return MarketsLoadingAnimation(context: context);
          else
            return _marketsLoaded(
                context, marketController.positiveMarketsList);
        }),
      ],
    );
  }

  Widget _marketsLoaded(
      BuildContext context, List<FormatedMarket> formatedMarketList) {
    return formatedMarketList.isEmpty
        ? EmptyMarkets()
        : Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: formatedMarketList.length,
              itemBuilder: (ctx, i) {
                return listPriceGainers(formatedMarketList[i], ctx);
              },
            ),
          );
  }

  Widget listPriceGainers(FormatedMarket formatedMarket, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 20.0),
      child: InkWell(
        onTap: () {
          marketController.selectedMarket.value = formatedMarket;
          Get.toNamed('/market-detail');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    formatedMarket.baseUnit.toUpperCase(),
                    style: TextStyle(fontFamily: "Popins", fontSize: 16.5),
                  ),
                  Text(
                    " / " + formatedMarket.quoteUnit.toUpperCase(),
                    style: TextStyle(
                        fontFamily: "Popins",
                        fontSize: 11.5,
                        color: Theme.of(ctx).hintColor),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Text(
                formatedMarket.last.toStringAsFixed(2),
                style: TextStyle(fontFamily: "Popins", fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                  width: 80.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      color: Color(0xFF00C087)),
                  child: Center(
                      child: Text(
                    formatedMarket.priceChangePercent,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
