import 'package:b4u_wallet/controllers/savings_controller.dart';
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
  final _savingController = Get.find<SavingsController>();

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.note_add),
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
