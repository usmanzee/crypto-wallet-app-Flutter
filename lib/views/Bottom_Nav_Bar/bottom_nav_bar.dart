// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:crypto_template/views/Bottom_Nav_Bar/custom_nav_bar.dart';
// import 'package:crypto_template/views/home/home.dart';
// import 'package:crypto_template/views/auth/login.dart';
// import 'package:crypto_template/views/market/markets.dart';
// import 'package:crypto_template/views/news/news_home.dart';
// import 'package:crypto_template/views/setting/setting.dart';
// import 'package:crypto_template/views/setting/themes.dart';
// import 'package:crypto_template/views/wallet/wallet.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:crypto_template/controllers/HomeController.dart';

// class BottomNavBar extends StatelessWidget {
//   final ThemeBloc themeBloc;
//   BottomNavBar({this.themeBloc});

//   final HomeController homeController = Get.put(HomeController());
//   Widget callPage(int current) {
//     switch (current) {
//       case 0:
//         return new Home();
//         break;
//       case 1:
//         return new market();
//         break;
//       case 2:
//         return new Wallet();
//         break;
//       case 3:
//         return new news();
//         break;
//       case 4:
//         return new setting(themeBloc: themeBloc);
//         break;
//       default:
//         return new Wallet();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => Center(
//           child: callPage(homeController.selectedNavIndex),
//         ),
//       ),
//       bottomNavigationBar: Obx(() {
//         return BottomNavigationDotBar(
//             color: Theme.of(context).hintColor,
//             items: <BottomNavigationDotBarItem>[
//               BottomNavigationDotBarItem(
//                 icon: Icons.home,
//                 onTap: () => homeController.selectedNavIndex = 0,
//               ),
//               BottomNavigationDotBarItem(
//                 icon: Icons.account_balance,
//                 onTap: () => homeController.selectedNavIndex = 1,
//               ),
//               BottomNavigationDotBarItem(
//                   icon: Icons.account_balance_wallet,
//                   onTap: () {
//                     if (true) {
//                       Get.toNamed('/login');
//                     } else {
//                       homeController.selectedNavIndex = 2;
//                     }
//                   }),
//               BottomNavigationDotBarItem(
//                   icon: Icons.library_books,
//                   onTap: () {
//                     homeController.selectedNavIndex = 3;
//                   }),
//               BottomNavigationDotBarItem(
//                   icon: Icons.settings,
//                   onTap: () {
//                     homeController.selectedNavIndex = 4;
//                   }),
//             ]);
//       }),
//     );
//   }
// }

import 'package:crypto_template/controllers/HomeController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/views/Bottom_Nav_Bar/custom_nav_bar.dart';
import 'package:crypto_template/views/home/home.dart';
import 'package:crypto_template/views/market/markets.dart';
import 'package:crypto_template/views/news/news_home.dart';
import 'package:crypto_template/views/setting/setting.dart';
import 'package:crypto_template/views/wallet/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatelessWidget {
  final HomeController homeController = Get.put(new HomeController());
  // final AuthController authController = Get.put(AuthController());
  // final List<Widget> bodyContent = [
  //   Home(),
  //   market(),
  //   Wallet(),
  //   news(),
  //   setting(),
  // ];
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Home();
        break;
      case 1:
        return new market();
        break;
      case 2:
        return new news();
        break;
      case 3:
        return new news();
        break;
      case 4:
        return new Wallet();
        break;
      default:
        return new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: callPage(homeController.selectedNavIndex),
          // child: bodyContent.elementAt(homeController.selectedNavIndex),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: "Markets",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insights),
                label: "Trades",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: "News",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.account_circle),
              //   label: "Settings",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: "Wallets",
              ),
            ],
            currentIndex: homeController.selectedNavIndex,
            onTap: (index) {
              var isLoggedIn = homeController.isLoggedIn;
              if (index == 4 && !isLoggedIn) {
                Get.toNamed('/login');
              } else {
                homeController.selectedNavIndex = index;
              }
            }
            // onTap: (index) => homeController.selectedNavIndex = index,
            ),
      ),
    );
  }
}
