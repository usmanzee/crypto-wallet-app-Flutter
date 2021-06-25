import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/savings_controller.dart';
import 'package:b4u_wallet/models/formated_market.dart';
import 'package:b4u_wallet/utils/router.dart';
import 'package:b4u_wallet/views/home/components/text_with_icon_widget.dart';
import 'package:b4u_wallet/views/webview_container.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/views/home/gainer.dart';
import 'package:b4u_wallet/views/home/loser.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:b4u_wallet/views/home/more_options_page.dart';

class Home extends StatelessWidget {
  final MarketController marketController = Get.find();
  final HomeController homeController = Get.find();

  final banners = [
    "assets/image/banner/banner2.png",
    "assets/image/banner/banner3.jpg",
  ];

  Widget imageCarousel(BuildContext context, List<dynamic> posts) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              height: 220.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                homeController.currentPos.value = index;
              },
            ),
            items: posts.length > 0
                ? posts.map(
                    (post) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                              child: Image.network(
                                post['_embedded']['wp:featuredmedia'][0]
                                        ['media_details']['sizes']
                                    ['medium_large']['source_url'],
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                              onTap: () {
                                Get.to(WebViewContainer('Post', post['link']));
                              });
                        },
                      );
                    },
                  ).toList()
                : banners
                    .map((item) => Container(
                          child: Center(
                              child: Image.asset(item,
                                  fit: BoxFit.cover, width: 1000)),
                        ))
                    .toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: posts.length > 0
              ? posts.map(
                  (image) {
                    int index = posts.indexOf(image);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: homeController.currentPos.value == index
                              ? Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor
                              : Theme.of(context).hintColor),
                    );
                  },
                ).toList()
              : banners.map(
                  (image) {
                    int index = banners.indexOf(image);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: homeController.currentPos.value == index
                              ? Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor
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
            color: Theme.of(context)
                .textSelectionTheme
                .selectionColor
                .withOpacity(0.6)),
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
            Obx(() {
              return !homeController.notificationSeen.value
                  ? Badge(
                      position: BadgePosition.topEnd(top: 10, end: 10),
                      badgeContent: null,
                      child: IconButton(
                        icon: Icon(Icons.notifications_none),
                        onPressed: () {
                          Get.toNamed('/notifications');
                          homeController.notificationSeen.value = true;
                          // homeController.isLoggedIn.value
                          //     ? Get.toNamed('/notifications')
                          //     : Get.toNamed('/login');
                        },
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.notifications_none),
                      onPressed: () {
                        Get.toNamed('/notifications');
                      },
                    );
            })
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Get.theme.canvasColor,
          child: Column(
            children: <Widget>[
              Container(
                height: 245.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                child: Obx(
                  () {
                    if (homeController.isLoadingWpPosts.value)
                      return Container(
                          width: double.infinity,
                          height: 200,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator());
                    else
                      return imageCarousel(context, homeController.wpPosts);
                  },
                ),
              ),
              Container(
                // height: 300.0,
                // width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33),
                  ),
                  // border: Border.all(color: Get.theme.hintColor,width: 0.5,),
                  /*boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor,
                        offset: Offset(0.0, 0.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],*/
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _linksCard(
                              context: context,
                              icon: Icons.vertical_align_bottom,
                              onPressed: () {
                                homeController.isLoggedIn.value
                                    ? Get.toNamed('/wallets-search',
                                        arguments: {'searchFrom': 'deposit'})
                                    : Get.toNamed('/login');
                              },
                              name: "home.screen.link.card.deposit".tr),
                          _linksCard(
                              context: context,
                              icon: Icons.vertical_align_top,
                              onPressed: () {
                                homeController.isLoggedIn.value
                                    ? Get.toNamed('/wallets-search',
                                        arguments: {'searchFrom': 'withdraw'})
                                    : Get.toNamed('/login');
                              },
                              name: "home.screen.link.card.withdraw".tr),
                          _linksCard(
                              context: context,
                              icon: Icons.swap_horiz,
                              onPressed: () {
                                homeController.isLoggedIn.value
                                    ? homeController.selectedNavIndex = 3
                                    : Get.toNamed('/login');
                              },
                              name: "home.screen.link.card.buy_sell".tr),
                          _linksCard(
                              context: context,
                              icon: Icons.insights,
                              onPressed: () {
                                homeController.selectedNavIndex = 2;
                              },
                              name: "home.screen.link.card.trade".tr),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _linksCard(
                              context: context,
                              icon: Icons.savings,
                              onPressed: () {
                                final controller = Get.put(SavingsController());
                                homeController.isLoggedIn.value
                                    ? Get.toNamed('/savings')
                                    : Get.toNamed('/login');
                              },
                              name: "home.screen.link.card.savings".tr),
                          _linksCard(
                              context: context,
                              icon: Icons.swap_horizontal_circle_outlined,
                              onPressed: () {
                                homeController.isLoggedIn.value
                                    ? Get.toNamed('/history')
                                    : Get.toNamed('/login');
                              },
                              name: "home.screen.link.card.history".tr),
                          _linksCard(
                              context: context,
                              icon: Icons.app_registration,
                              onPressed: () {
                                Get.to<void>(() => MoreOptionsPage());
                              },
                              name: "home.screen.link.card.more".tr),
                          Expanded(
                            child: Text(''),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showDialog(
                          context: context,
                          heading: 'home.screen.link.card.p2p_trading'.tr,
                        ),
                        child: textWithIconWidget(
                          title: 'home.screen.link.card.p2p_trading'.tr,
                          icon: Icons.people,
                          subtitle1: 'home.screen.link.card.bank_Transfer'.tr,
                          subtitle2: 'home.screen.link.card.paypal_revoult'.tr,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showDialog(
                          context: context,
                          heading: 'home.screen.link.card.credit_debit_card'.tr,
                        ),
                        child: textWithIconWidget(
                          title: 'home.screen.link.card.credit_debit_card'.tr,
                          icon: Icons.credit_card,
                          subtitle1:
                              'home.screen.link.card.visa_master_card'.tr,
                          subtitle2: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  if (marketController.isLoading.value)
                    return _loadingCardAnimation(context);
                  else
                    return Container(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: _cardLoaded(
                          context, marketController.formatedMarketsList),
                    );
                },
              ),
              ///
              /// Tab bar custom
              ///
              Container(
                // height: 300.0,
                color: Get.theme.scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TabBar(
                              indicatorColor: Theme.of(context).primaryColor,
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                color: Get.theme.canvasColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              tabs: [
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "home.screen.tabs.gainers".tr,
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                      ),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "home.screen.tabs.losers".tr,
                                      style: TextStyle(fontFamily: 'Popins'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 240.0,
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TabBarView(
                              children: [
                                Gainer(),
                                Loser(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(
                              53.0), // here the desired height
                          child: AppBar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0.0,
                            // centerTitle: true,
                            flexibleSpace: SafeArea(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 100.0),
                                  child:  TabBar(
                                    indicatorColor:
                                    Theme.of(context).primaryColor,
                                    labelColor: Theme.of(context).primaryColor,
                                    unselectedLabelColor: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    tabs: [
                                      Tab(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "home.screen.tabs.gainers".tr,
                                                style: TextStyle(
                                                    fontFamily: "Popins"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "home.screen.tabs.losers".tr,
                                                style: TextStyle(
                                                    fontFamily: 'Popins'),
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
                          child: TabBarView(
                            children: [
                              Gainer(),
                              Loser(),
                            ],
                          ),
                        ),
                      ),*/
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final FormatedMarket formatedMarket;
  final MarketController marketController = Get.find<MarketController>();
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

  Card({this.formatedMarket});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3.0,
      ),
      child: InkWell(
        onTap: () {
          // MarketController marketController = Get.find();
          marketController.selectedMarket.value = formatedMarket;
          Get.toNamed('/market-detail');
        },
        child: Container(
          height: 100.0,
          width: _width / 3.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).scaffoldBackgroundColor,
            /*boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: Offset(0.1, 1.0),
              ),
            ],*/
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /* Text(
                      formatedMarket.name.toUpperCase(),
                      style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatedMarket.name.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontFamily: "Popins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                          /*Text(
                            formatedMarket.last.toStringAsFixed(2),
                            style: TextStyle(
                                color: formatedMarket.isPositiveChange
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                fontFamily: "Popins",
                                fontSize: 13.5),
                          ),*/
                          Text(
                            formatedMarket.priceChangePercent,
                            style: TextStyle(
                              color: formatedMarket.isPositiveChange
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatedMarket.last.toStringAsFixed(2),
                      style: TextStyle(
                          color: formatedMarket.isPositiveChange
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontFamily: "Popins",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(right: 30),
                  height: 30.0,
                  child: Sparkline(
                    data: !marketController.isSparkLinesLoading.value &&
                            (formatedMarket.sparkLineData != null &&
                                formatedMarket.sparkLineData.length > 0)
                        ? formatedMarket.sparkLineData
                        : data,
                    lineWidth: 0.3,
                    fillMode: FillMode.below,
                    lineColor: marketController.isSparkLinesLoading.value
                        ? Theme.of(context).hintColor.withOpacity(0.5)
                        : Theme.of(context).accentColor,
                    fillGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        marketController.isSparkLinesLoading.value
                            ? Theme.of(context).hintColor.withOpacity(0.5)
                            : Theme.of(context).accentColor.withOpacity(0.2),
                        marketController.isSparkLinesLoading.value
                            ? Theme.of(context).hintColor.withOpacity(0.01)
                            : Theme.of(context).accentColor.withOpacity(0.01),
                        // Theme.of(context).accentColor.withOpacity(0.01)
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Container(
        height: 70.0,
        width: _width / 2.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.1),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: Offset(0.1, 1.0),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Theme.of(context).hintColor.withOpacity(0.3),
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
                          color: Theme.of(context).hintColor.withOpacity(0.2),
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
                child: Sparkline(
                  data: data,
                  lineWidth: 0.3,
                  fillMode: FillMode.below,
                  lineColor: Theme.of(context).hintColor.withOpacity(0.2),
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).hintColor.withOpacity(0.2),
                      Theme.of(context).hintColor.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              formatedMarket: formatedMarketList[0],
            ),
            Card(
              formatedMarket: formatedMarketList[1],
            ),
            Card(
              formatedMarket: formatedMarketList[2],
            ),
          ],
        );
  /*GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 1.745,
          crossAxisCount: 2,
          primary: false,
          children: List.generate(
            formatedMarketList.length > 4 ? 4 : formatedMarketList.length,
            (index) => Card(
              formatedMarket: formatedMarketList[index],
            ),
          ),
        );*/
}

Widget _linksCard(
    {context, IconData icon, VoidCallback onPressed, String name}) {
  return Expanded(
    flex: 1,
    child: InkWell(
      onTap: onPressed,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            size: 26.0,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Popins",
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              // maxLines: 2,
            ),
          ),
        ],
      ),
    ),
  );
}

void _showDialog({BuildContext context, String heading}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        title: Center(child: Text(heading)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('This feature is coming soon...'),
          ],
        ),
      );
    },
  );
}
