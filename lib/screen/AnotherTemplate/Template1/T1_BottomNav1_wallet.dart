import 'package:crypto_template/screen/AnotherTemplate/Template1/tab_wallet/T1_btc.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/tab_wallet/T1_dash.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/tab_wallet/T1_eth.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/tab_wallet/T1_lrm.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template1/tab_wallet/T1_ripple.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/component/style.dart';
import 'package:carousel_slider/carousel_slider.dart';

class T1_wallet extends StatefulWidget {
  final Widget child;

  T1_wallet({Key key, this.child}) : super(key: key);

  _T1_walletState createState() => _T1_walletState();
}

class _T1_walletState extends State<T1_wallet>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  /// Set Top App Navigation Bar
  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this, initialIndex: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141C35),

      ///
      /// Appbar
      ///
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0xFF141C35),
        centerTitle: true,
        title: Text(
          "Wallet",
          style: TextStyle(color: Colors.white, fontFamily: "Gotik"),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              "assets/image/messageAppbar.png",
              color: Colors.white,
              height: 20.0,
              width: 20.0,
            ),
          )
        ],
      ),

      ///
      /// Set container for tab bar custom in top (bottom appbar)
      ///
      body: ListView(
        children: <Widget>[
          Container(
            color: Color(0xFF141C35),
            height: 600.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                ///
                /// Custom tab bar
                ///
                Expanded(
                  child: DefaultTabController(
                    length: 5,
                    child: new Scaffold(
                      backgroundColor: Color(0xFF141C35),
                      appBar: PreferredSize(
                        preferredSize:
                            Size.fromHeight(53.0), // here the desired height
                        child: new AppBar(
                          backgroundColor: Color(0xFF141C35),
                          elevation: 0.0,
                          centerTitle: true,
                          flexibleSpace: SafeArea(
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 46.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 2.5,
                                    color: Colors.white12.withOpacity(0.1),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 50.0, left: 50.0),
                                    child: new TabBar(
                                      // labelColor: Theme.of(context).primaryColor,
                                      indicatorColor: colorStyle.primaryColor,
                                      labelColor:
                                          Theme.of(context).primaryColor,
                                      unselectedLabelColor: Colors.white24,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      tabs: [
                                        new Tab(
                                          child: Icon(
                                            IconData(0xe900,
                                                fontFamily: 'tab1'),
                                            size: 19.0,
                                          ),
                                        ),
                                        new Tab(
                                          child: Icon(
                                            IconData(0xe900,
                                                fontFamily: 'tab2'),
                                            size: 21.0,
                                          ),
                                        ),
                                        new Tab(
                                          child: Icon(
                                            IconData(0xe901,
                                                fontFamily: 'tab3'),
                                            size: 23.0,
                                          ),
                                        ),
                                        new Tab(
                                          child: Icon(
                                            IconData(0xe902,
                                                fontFamily: 'tab4'),
                                            size: 22.0,
                                          ),
                                        ),
                                        new Tab(
                                          child: Icon(
                                            IconData(0xe903,
                                                fontFamily: 'tab5'),
                                            size: 16.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          automaticallyImplyLeading: false,
                        ),
                      ),

                      ///
                      /// Body for tab bar
                      ///
                      body: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: new TabBarView(
                          children: [
                            T1_lrm(),
                            T1_ripple(),
                            T1_eth(),
                            T1_btc(),
                            T1_dash(),
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
    );
  }
}
