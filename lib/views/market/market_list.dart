import 'package:b4u_wallet/component/no_data.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/models/formated_market.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class MarketList extends StatelessWidget {
  final Widget child;

  MarketList({Key key, this.child}) : super(key: key);

  final MarketController marketController = Get.find();

  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Container(
                    child: Text(
                  "markets.screen.column.pair".tr,
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 14.5,
                      fontFamily: "Popins"),
                )),
              ),
              Container(
                  child: Text(
                "markets.screen.column.last_price".tr,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 14.5,
                    fontFamily: "Popins"),
              )),
              Container(
                  child: Text(
                "markets.screen.column.24hr_change".tr,
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: 14.5,
                    fontFamily: "Popins"),
              )),
            ],
          ),
        ),
        Obx(() {
          if (marketController.isLoading.value)
            return _loadingData(context);
          else
            return _dataLoaded(context, marketController.formatedMarketsList);
        }),
      ],
    ));
  }

  Widget _loadingData(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 20,
        itemBuilder: (ctx, i) {
          return loadingCard(ctx);
        },
      ),
    );
  }

  Widget loadingCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Shimmer.fromColors(
        baseColor: Color(0xFF3B4659),
        highlightColor: Color(0xFF606B78),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).hintColor.withOpacity(0.2),
                          radius: 13.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 15.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Container(
                              height: 12.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 15.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 12.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: 25.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                )
              ],
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
      ),
    );
  }

  Widget _dataLoaded(
      BuildContext context, List<FormatedMarket> formatedMarketList) {
    return formatedMarketList.isEmpty
        ? NoData()
        : Container(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: formatedMarketList.length,
              itemBuilder: (ctx, i) {
                return card(ctx, formatedMarketList[i]);
              },
            ),
          );
  }

  Widget card(BuildContext ctx, FormatedMarket formatedMarket) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              marketController.selectedMarket.value = formatedMarket;
              Get.toNamed('/market-detail');
            },
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
                      Container(
                        width: 95.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  formatedMarket.baseUnit.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  " /" + formatedMarket.quoteUnit.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Popins",
                                      fontSize: 12,
                                      color: Theme.of(ctx).hintColor),
                                ),
                              ],
                            ),
                            Text(
                              'markets.screen.vol'.tr +
                                  ' ' +
                                  formatedMarket.volume.toStringAsFixed(2),
                              style: TextStyle(
                                  fontFamily: "Popins",
                                  fontSize: 10,
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
                        formatedMarket.last.toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '\$' + formatedMarket.priceInUsd,
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 12,
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
                          color: formatedMarket.isPositiveChange
                              ? Color(0xFF00C087)
                              : Colors.redAccent),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          formatedMarket.priceChangePercent,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
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
}
