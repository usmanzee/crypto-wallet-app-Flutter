import 'package:b4u_wallet/views/savings/tabs/flexible.dart';
import 'package:b4u_wallet/views/savings/tabs/locked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Savings extends StatefulWidget {
  @override
  _SavingsState createState() => _SavingsState();
}

class _SavingsState extends State<Savings> with SingleTickerProviderStateMixin {
  TabController _tabController;

  // final _savingController = Get.find<SavingsController>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*  print(_savingController.plansList.length);
      print(_savingController.totalPlans);*/
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        centerTitle: true,
        elevation: 0,
        title: TabBar(
          indicatorColor: Get.theme.primaryColor,
          labelColor: Get.theme.primaryColor,
          unselectedLabelColor: Get.theme.textSelectionTheme.selectionColor,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Flexible',
              ),
            ),
            Tab(
              child: Text(
                'Locked',
              ),
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Get.theme.hintColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => Get.toNamed('/saving_history_page'),
              child: Icon(
                Icons.note_add,
                size: 25,
                color: Get.theme.hintColor,
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FlexibleTab(),
          LockedTab(),
        ],
      ),
    );
  }
}
