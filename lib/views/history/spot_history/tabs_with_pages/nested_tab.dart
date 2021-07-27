import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _nestedTabController,
          // indicatorColor: Get.theme.hintColor.withOpacity(0.5),
          labelColor: Get.theme.textSelectionTheme.selectionColor,
          unselectedLabelColor: Get.theme.hintColor,
          isScrollable: true,
          indicator: BoxDecoration(
            color: Get.theme.canvasColor,
            borderRadius: BorderRadius.circular(3),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(
              text: "Crypto",
            ),
            Tab(
              text: "Cash",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _nestedTabController,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}