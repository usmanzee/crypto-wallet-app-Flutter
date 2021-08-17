import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_initial_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_orders_history_page.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/p2p_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBottomNavPage extends StatelessWidget {
  final _p2pController = Get.find<P2pController>();
  final _widgetList = [
    P2pInitialPage(),
    P2pOrdersHistoryPage(),
    P2pAdsPage(),
    P2pUserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _widgetList[_p2pController.initialIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Get.theme.accentColor,
          unselectedItemColor: Get.theme.hintColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: "bottom.navbar.home".tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reorder),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leak_add),
              label: 'Ads',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.library_books),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: _p2pController.initialIndex.value,
          onTap: (index) {
            if (index != _p2pController.initialIndex.value) {
              _p2pController.initialIndex.value = index;
              // print(_p2pController.initialIndex.value);
            }
          },
        ),
      ),
    );
  }
}
