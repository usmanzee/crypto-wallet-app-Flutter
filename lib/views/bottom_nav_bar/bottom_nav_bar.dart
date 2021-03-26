import 'package:crypto_template/component/no_internet.dart';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/controllers/swap_controller.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/controllers/web_socket_controller.dart';
import 'package:crypto_template/views/swap/swap.dart';
import 'package:crypto_template/views/trading/trading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/views/home/home.dart';
import 'package:crypto_template/views/market/markets.dart';
import 'package:crypto_template/views/wallet/wallets.dart';
import 'package:crypto_template/controllers/SnackbarController.dart';

class BottomNavBar extends GetView<HomeController> {
  final MarketController marketController = Get.put(MarketController());
  final WebSocketController webSocketController = Get.find();
  DateTime currentBackPressTime;
  Widget callPage(int current, bool hasConnection) {
    if (hasConnection) {
      switch (current) {
        case 0:
          return RefreshIndicator(
              onRefresh: controller.refreshHomePage, child: new Home());
          break;
        case 1:
          return RefreshIndicator(
              onRefresh: controller.refreshMarketsPage, child: new Market());
          break;
        case 2:
          return RefreshIndicator(
              onRefresh: controller.refreshTradingPage, child: new Trading());
          break;
        case 3:
          return new Swap();
          break;
        case 4:
          return RefreshIndicator(
              onRefresh: controller.refreshWalletsPage, child: new Wallets());
          break;
        default:
          return RefreshIndicator(
              onRefresh: controller.refreshHomePage, child: new Home());
      }
    } else {
      return NoInternet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Obx(
          () => Center(
            child:
                callPage(controller.selectedNavIndex, controller.hasConnection),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "bottom.navbar.home".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.leaderboard),
                    label: "bottom.navbar.markets".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.insights),
                    label: "bottom.navbar.trading".tr,
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.library_books),
                    icon: Icon(Icons.swap_horiz),
                    label: "bottom.navbar.buy_sell".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet),
                    label: "bottom.navbar.wallets".tr,
                  ),
                ],
                currentIndex: controller.selectedNavIndex,
                onTap: (index) {
                  var isLoggedIn = controller.isLoggedIn;

                  if (index == 4 && !isLoggedIn.value) {
                    Get.toNamed('/login');
                  } else if (index == 3 && !isLoggedIn.value) {
                    Get.toNamed('/login');
                  } else {
                    controller.selectedNavIndex = index;
                  }
                  if (index != 2) {
                    bool tradingControllerInstance =
                        Get.isRegistered<TradingController>();
                    if (tradingControllerInstance) {
                      Get.delete<TradingController>(force: true);
                    }
                  }
                  if (index != 3) {
                    bool swapControllerInstance =
                        Get.isRegistered<SwapController>();
                    if (swapControllerInstance) {
                      Get.delete<SwapController>(force: true);
                    }
                  }
                }),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      displayBackWarning();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void displayBackWarning() {
    SnackbarController snackbarController =
        new SnackbarController(title: '', message: 'Press back again to leave');
    snackbarController.showSnackbar();
  }
}