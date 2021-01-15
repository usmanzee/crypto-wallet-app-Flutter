import 'dart:async';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/views/setting/setting.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/MarketController.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/component/modelGridHome.dart';
import 'package:crypto_template/views/DetailCryptoValue/market_detail.dart';
import 'package:crypto_template/views/home/gainer.dart';
import 'package:crypto_template/views/home/loser.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:crypto_template/component/style.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  final marketController = Get.put(MarketController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1.0,
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionColor.withOpacity(0.6)),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              tooltip: 'Profile settings',
              onPressed: () {
                Get.to(Setting());
              },
            ),
            Spacer(flex: 1),
            IconButton(
              icon: Icon(Icons.notifications_none),
              tooltip: 'Notification',
              onPressed: () {
                Get.to(Setting());
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // /
            // / Header image slider
            // /
            SizedBox(
                height: 100.0,
                width: double.infinity,
                child: new Carousel(
                  boxFit: BoxFit.cover,
                  dotColor: Colors.white.withOpacity(0.8),
                  dotSize: 5.5,
                  dotSpacing: 16.0,
                  dotBgColor: Colors.transparent,
                  showIndicator: true,
                  // overlayShadow: true,
                  // overlayShadowColors: Theme.of(context)
                  //     .scaffoldBackgroundColor
                  //     .withOpacity(0.9),
                  // overlayShadowSize: 0.25,
                  images: [
                    AssetImage("assets/image/banner/banner2.png"),
                    AssetImage("assets/image/banner/banner3.jpg"),
                    AssetImage("assets/image/banner/banner2.png"),
                    AssetImage("assets/image/banner/banner3.jpg"),
                  ],
                )),
            SizedBox(height: 10.0),

            Obx(() {
              if (marketController.isLoading.value)
                return _loadingCardAnimation(context);
              else
                return _cardLoaded(
                    context, marketController.formatedMarketsList);
            }),

            ///
            /// Tab bar custom
            ///
            Container(
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: new Scaffold(
                        appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(53.0), // here the desired height
                          child: new AppBar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0.0,
                            centerTitle: true,
                            flexibleSpace: SafeArea(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 100.0),
                                  child: new TabBar(
                                    indicatorColor:
                                        Theme.of(context).primaryColor,
                                    labelColor: Theme.of(context).primaryColor,
                                    unselectedLabelColor:
                                        Theme.of(context).textSelectionColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    tabs: [
                                      new Tab(
                                        child: Row(
                                          children: <Widget>[
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       left: 4.0),
                                            //   child: Icon(
                                            //     IconData(0xe900,
                                            //         fontFamily: 'gainers'),
                                            //     size: 15.0,
                                            //   ),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Gainers",
                                                style: TextStyle(
                                                    fontFamily: "Sans"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      new Tab(
                                        child: Row(
                                          children: <Widget>[
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       left: 8.0),
                                            //   child: Icon(
                                            //     IconData(0xe901,
                                            //         fontFamily: 'loser'),
                                            //     size: 15.0,
                                            //   ),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text("Losers"),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            automaticallyImplyLeading: false,
                          ),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new TabBarView(
                            children: [
                              Gainer(),
                              Loser(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final gridHome item;
  final FormatedMarket formatedMarket;
  Card(this.item, this.formatedMarket);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: InkWell(
        onTap: () {
          Get.to(MarketDetail(
            item: item,
            formatedMarket: formatedMarket,
          ));
        },
        child: Container(
          height: 70.0,
          width: _width / 2.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.1, 1.0))
              ]),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      formatedMarket.name.toUpperCase(),
                      style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            formatedMarket.last.toString(),
                            style: TextStyle(
                                color: formatedMarket.isPositiveChange
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                fontFamily: "Gotik",
                                fontSize: 13.5),
                          ),
                          Text(
                            formatedMarket.priceChangePercent,
                            style: TextStyle(
                                color: formatedMarket.isPositiveChange
                                    ? Colors.greenAccent
                                    : Colors.redAccent),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30.0,
                  child: new Sparkline(
                    data: item.data,
                    lineWidth: 0.3,
                    fillMode: FillMode.below,
                    lineColor: Theme.of(context).accentColor,
                    fillGradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).accentColor.withOpacity(0.2),
                        Theme.of(context).accentColor.withOpacity(0.01)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardLoading extends StatelessWidget {
  // final gridHome item;
  // CardLoading(this.item);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Container(
        height: 70.0,
        width: _width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).canvasColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.1, 1.0))
            ]),
        child: Shimmer.fromColors(
          baseColor: Color(0xFF3B4659),
          highlightColor: Color(0xFF606B78),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).hintColor,
                      height: 20.0,
                      width: 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 17.0,
                            width: 70.0,
                          ),
                          Container(
                            color: Theme.of(context).hintColor,
                            height: 17.0,
                            width: 70.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30.0,
                  // child: new Sparkline(
                  //   data: item.data,
                  //   lineWidth: 0.3,
                  //   fillMode: FillMode.below,
                  //   lineColor: item.chartColor,
                  //   fillGradient: new LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: item.chartColorGradient,
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingCardAnimation(BuildContext context) {
  return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.745,
      crossAxisCount: 2,
      primary: false,
      children: List.generate(
        4,
        // (index) => CardLoading(listGridHome[index]),
        (index) => CardLoading(),
      ));
}

///
///
/// Calling ImageLoaded animation for set a grid layout
///
///
Widget _cardLoaded(
    BuildContext context, List<FormatedMarket> formatedMarketList) {
  return formatedMarketList.isEmpty
      ? Container()
      : GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 1.745,
          crossAxisCount: 2,
          primary: false,
          children: List.generate(
            listGridHome.length,
            (index) => Card(listGridHome[index], formatedMarketList[index]),
          ));
}
