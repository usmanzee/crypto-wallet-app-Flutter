import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_deals.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_finance.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_history.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_home.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template3/T3_wallet.dart';
import 'package:flutter/material.dart';

class T3_Dashboard extends StatefulWidget {
  T3_Dashboard({Key key}) : super(key: key);

  _T3_DashboardState createState() => _T3_DashboardState();
}

class _T3_DashboardState extends State<T3_Dashboard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

///
/// Initstate for tab bar
///
  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this, initialIndex: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///
      /// Appbar
      /// 
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0xFF4d2a86),
        centerTitle: false,
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


      body: ListView(
        primary: true,
        shrinkWrap: false,
        children: <Widget>[
          Container(
            color: Color(0xFF4d2a86),
            height: 800.0,
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
                      backgroundColor: Color(0xFF4d2a86),
                      appBar: PreferredSize(
                        preferredSize:
                            Size.fromHeight(70.0), // here the desired height
                        child: new AppBar(
                          backgroundColor: Color(0xFF4d2a86),
                          elevation: 0.0,
                          centerTitle: true,
                          flexibleSpace: SafeArea(
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 68.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 4.1,
                                    color: Colors.white12.withOpacity(0.1),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0.0, left: 0.0),
                                    child: new TabBar(
                                      indicatorColor: Colors.white,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.white24,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      tabs: [
                                        new Tab(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            size: 19.0,
                                          ),
                                          text: "Home",
                                        ),
                                        new Tab(
                                          icon: Icon(
                                            Icons.work,
                                            size: 19.0,
                                          ),
                                          text: "Deals",
                                        ),
                                        new Tab(
                                          icon: Icon(
                                            Icons.account_balance,
                                            size: 19.0,
                                          ),
                                          text: "Wallet",
                                        ),
                                        new Tab(
                                          icon: Icon(
                                            Icons.monetization_on,
                                            size: 19.0,
                                          ),
                                          text: "Finance",
                                        ),
                                        new Tab(
                                          icon: Icon(
                                            Icons.signal_cellular_4_bar,
                                            size: 19.0,
                                          ),
                                          text: "History",
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
                            T3_HomeScreen(),
                            T3_deals(),
                            T3_wallet(),
                            T3_finance(),
                            T3_history(),
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
