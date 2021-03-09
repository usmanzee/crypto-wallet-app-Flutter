import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/views/webview_container.dart';
import 'package:get/get.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/views/home/gainer.dart';
import 'package:crypto_template/views/home/loser.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:shimmer/shimmer.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  final MarketController marketController = Get.find();
  final HomeController homeController = Get.find();

  Widget imageCarousel(BuildContext context, List<dynamic> posts) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                homeController.currentPos.value = index;
              }),
          items: posts.map((post) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(
                            post['_embedded']['wp:featuredmedia'][0]
                                    ['media_details']['sizes']['medium_large']
                                ['source_url'],
                            fit: BoxFit.fill),
                        onTap: () {
                          Get.to(WebViewContainer('Post', post['link']));
                        }));
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: posts.map(
            (image) {
              int index = posts.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.currentPos.value == index
                        ? Theme.of(context).textSelectionColor
                        : Theme.of(context).hintColor),
              );
            },
          ).toList(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        backgroundColor: Theme.of(context).canvasColor,
        // elevation: 1.0,
        iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionColor.withOpacity(0.6)),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              tooltip: 'Profile settings',
              onPressed: () {
                Get.toNamed('/settings');
              },
            ),
            Spacer(flex: 1),
            InkWell(
              onTap: () {
                homeController.isLoggedIn.value
                    ? Get.toNamed('/notifications')
                    : Get.toNamed('/login');
              },
              child: Badge(
                position: BadgePosition.topEnd(top: 10, end: 10),
                badgeContent: null,
                child: IconButton(
                  icon: Icon(Icons.notifications_none),
                  onPressed: () {
                    homeController.isLoggedIn.value
                        ? Get.toNamed('/notifications')
                        : Get.toNamed('/login');
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // MaterialButton(
            //     child: Text('Get Posts'),
            //     onPressed: () {
            //       homeController.getWPPosts();
            //     }),

            Container(
                height: 205.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).canvasColor),
                child: Obx(() {
                  if (homeController.isLoadingWpPosts.value)
                    return Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  else
                    return imageCarousel(context, homeController.wpPosts);
                })),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 100.0,
                margin: const EdgeInsets.only(top: 4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor,
                        offset: Offset(0.0, 0.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _linksCard(
                        context,
                        Icon(
                          Icons.vertical_align_bottom,
                          size: 26.0,
                          color: Theme.of(context).accentColor,
                        ), () {
                      homeController.isLoggedIn.value
                          ? Get.toNamed('/wallets-search',
                              arguments: {'searchFrom': 'deposit'})
                          : Get.toNamed('/login');
                    }, "Deposit"),
                    _linksCard(
                        context,
                        Icon(
                          Icons.vertical_align_top,
                          size: 26.0,
                          color: Theme.of(context).accentColor,
                        ), () {
                      homeController.isLoggedIn.value
                          ? Get.toNamed('/wallets-search',
                              arguments: {'searchFrom': 'withdraw'})
                          : Get.toNamed('/login');
                    }, "Withdraw"),
                    _linksCard(
                        context,
                        Icon(
                          Icons.swap_horiz,
                          size: 26.0,
                          color: Theme.of(context).accentColor,
                        ), () {
                      homeController.isLoggedIn.value
                          ? homeController.selectedNavIndex = 3
                          : Get.toNamed('/login');
                    }, "Buy/Sell"),
                    _linksCard(
                        context,
                        Icon(
                          Icons.insights,
                          size: 26.0,
                          color: Theme.of(context).accentColor,
                        ), () {
                      homeController.selectedNavIndex = 2;
                    }, "Trading"),
                  ],
                ),
              ),
            ),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Losers",
                                                style: TextStyle(
                                                    fontFamily: 'Sans'),
                                              ),
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
  final FormatedMarket formatedMarket;
  final data = [
    0.0,
    0.5,
    0.9,
    1.4,
    2.2,
    1.0,
    3.3,
    0.0,
    -0.5,
    -1.0,
    -0.5,
    2.0,
    4.0
  ];
  Card(this.formatedMarket);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: InkWell(
        onTap: () {
          MarketController marketController = Get.find();
          marketController.selectedMarket.value = formatedMarket;
          Get.toNamed('/market-detail');
        },
        child: Container(
          height: 70.0,
          width: _width / 2.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
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
                          fontFamily: "sans",
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
                            formatedMarket.last.toStringAsFixed(2),
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
                    data: data,
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
            formatedMarketList.length > 4 ? 4 : formatedMarketList.length,
            (index) => Card(formatedMarketList[index]),
          ));
}

Widget _linksCard(context, Widget icon, VoidCallback onPressed, String name) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 8.0, right: 1.0, bottom: 8.0, top: 8.0),
    child: InkWell(
      onTap: onPressed,
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.1, 1.0))
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 25.0,
                width: 25.0,
                child: icon,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(name,
                  style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Sans"))
            ],
          ),
        ),
      ),
    ),
  );
}
