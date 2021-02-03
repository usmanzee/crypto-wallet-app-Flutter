import 'package:crypto_template/component/market/btcModel.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/market_detail_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/views/DetailCryptoValue/market_detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class MarketDrawer extends StatefulWidget {
  final String screen;
  MarketDrawer({this.screen});
  @override
  _MarketDrawerState createState() => _MarketDrawerState(screen: screen);
}

class _MarketDrawerState extends State<MarketDrawer>
    with SingleTickerProviderStateMixin {
  final String screen;
  _MarketDrawerState({this.screen});
  final MarketController marketController = Get.find();
  final List<Widget> myTabs = [
    Tab(text: 'All'),
    Tab(text: 'BTC'),
    Tab(text: 'USD'),
  ];

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 0, 0),
            child: Text(
              'Markets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            margin: EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    cursorColor: Theme.of(context).textSelectionColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle: TextStyle(
                          color: Theme.of(context).textSelectionColor),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      isDense: true,
                    ),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Obx(() {
              if (marketController.isLoading.value)
                return _loadingData(context);
              else
                return _dataLoaded(
                    context, marketController.formatedMarketsList, screen);
            }),
          ),
          // TabBar(
          //   controller: _tabController,
          //   tabs: myTabs,
          //   indicatorColor: Theme.of(context).primaryColor,
          //   labelColor: Theme.of(context).primaryColor,
          //   unselectedLabelColor: Theme.of(context).textSelectionColor,
          //   indicatorSize: TabBarIndicatorSize.label,
          // ),
          // Center(
          //   child: [
          //     Column(
          //       children: [
          //         Text('first tab'),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Text('second tab'),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Text('third tab'),
          //       ],
          //     ),
          //   ][_tabController.index],
          // ),
        ],
      ),
    );
  }
}

Widget _loadingData(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: btcMarketList.length,
      itemBuilder: (ctx, i) {
        return loadingCard(ctx, btcMarketList[i]);
      },
    ),
  );
}

Widget loadingCard(BuildContext ctx, btcMarket item) {
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
                        backgroundColor: Theme.of(ctx).hintColor,
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
                                  color: Theme.of(ctx).hintColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 12.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                                color: Theme.of(ctx).hintColor,
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
                            color: Theme.of(ctx).hintColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          height: 12.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                              color: Theme.of(ctx).hintColor,
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
                      color: Theme.of(ctx).hintColor,
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

Widget _dataLoaded(BuildContext context,
    List<FormatedMarket> formatedMarketList, String screenType) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: formatedMarketList.length,
      itemBuilder: (ctx, i) {
        return card(ctx, formatedMarketList[i], screenType);
      },
    ),
  );
}

Widget card(BuildContext context, FormatedMarket formatedMarket, screenType) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Get.back();
            if (screenType == 'market_detail') {
              MarketDetailController marketDetailController = Get.find();
              marketDetailController.updateCurrentMarket(formatedMarket);
            } else {
              TradingController tradingController = Get.find();
              tradingController.updateCurrentMarket(formatedMarket);
            }
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
                                    fontFamily: "Popins", fontSize: 16.5),
                              ),
                              Text(
                                " / " + formatedMarket.quoteUnit.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    fontSize: 11.5,
                                    color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                          Text(
                            'Vol ' + formatedMarket.volume.toString(),
                            style: TextStyle(
                                fontFamily: "Popins",
                                fontSize: 11.5,
                                color: Theme.of(context).hintColor),
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
                      formatedMarket.last
                          .toStringAsFixed(formatedMarket.amountPrecision),
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      formatedMarket.priceChangePercent,
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontSize: 11.5,
                          color: formatedMarket.isPositiveChange
                              ? Color(0xFF00C087)
                              : Colors.redAccent),
                    ),
                  ],
                ),
              ),
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
