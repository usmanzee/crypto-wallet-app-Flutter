import 'package:b4u_wallet/views/history/spot_history/tabs_with_pages/nested_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotHistoryPage extends StatefulWidget {
  @override
  _SpotHistoryPageState createState() => _SpotHistoryPageState();
}

class _SpotHistoryPageState extends State<SpotHistoryPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        elevation: 0.5,
        title: Text(
          'History',
          style: TextStyle(
            fontFamily: "Popins",
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(49),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4,
                    color: Get.theme.accentColor,
                  ),
                  insets: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                ),
                controller: _tabController,
                indicatorColor: Get.theme.accentColor,
                labelColor: Get.theme.textSelectionTheme.selectionColor,
                unselectedLabelColor: Get.theme.hintColor,
                labelPadding: EdgeInsets.only(right: 8, left: 8),
                isScrollable: true,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.pink,
                ),
                tabs: [
                  Tab(
                    text: ('Deposit'),
                  ),
                  Tab(
                    text: ('Withdrawal'),
                  ),
                  Tab(
                    text: ('Transfer'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        children: [
          NestedTabBar(),
          NestedTabBar(),
          NestedTabBar(),
        ],
        controller: _tabController,
      ),
    );
  }
}


