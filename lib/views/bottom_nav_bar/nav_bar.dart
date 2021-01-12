import 'package:crypto_template/views/bottom_nav_bar/custom_nav_bar.dart';
import 'package:crypto_template/views/wallet/wallets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationDotBar(
        // Usar -> "BottomNavigationDotBar"
        color: Theme.of(context).hintColor,
        items: <BottomNavigationDotBarItem>[
          BottomNavigationDotBarItem(
              icon: Icons.home,
              onTap: () {
                Get.offNamed('/home');
              }),
          BottomNavigationDotBarItem(icon: Icons.account_balance, onTap: () {}),
          BottomNavigationDotBarItem(
              icon: Icons.account_balance_wallet,
              onTap: () {
                Get.off(Wallets());
              }),
          BottomNavigationDotBarItem(icon: Icons.library_books, onTap: () {}),
          BottomNavigationDotBarItem(icon: Icons.settings, onTap: () {}),
        ]);
  }
}
