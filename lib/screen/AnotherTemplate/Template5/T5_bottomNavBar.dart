import 'package:crypto_template/screen/AnotherTemplate/Template5/T5_home.dart';
import 'package:flutter/material.dart';

import 'T5_budget.dart';
import 'T5_profile.dart';
import 'T5_tabBar_home.dart';
import 'T5_wallet.dart';

class T5_bottomNavBar extends StatefulWidget {
  T5_bottomNavBar({Key key}) : super(key: key);

  _T5_bottomNavBarState createState() => _T5_bottomNavBarState();
}

class _T5_bottomNavBarState extends State<T5_bottomNavBar> {
  int currentIndex = 0;

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new T5_tabBar_home();
      case 1:
        return new T5_budget();
      case 2:
        return new T5_wallet();
      case 3:
        return new T5_profile();
        break;
      default:
        return T5_home();
    }
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(color: Colors.black26.withOpacity(0.15)))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            fixedColor: Colors.greenAccent,
            onTap: (value) {
              currentIndex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 23.0,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      fontFamily: "Berlin",
                      letterSpacing: 0.5,
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_balance_wallet,
                  ),
                  title: Text(
                    "Budget",
                    style: TextStyle(
                      fontFamily: "Berlin",
                      letterSpacing: 0.5,
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card,
                  ),
                  title: Text(
                    "Card",
                    style: TextStyle(
                      fontFamily: "Berlin",
                      letterSpacing: 0.5,
                    ),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                  title: Text(
                    "Acount",
                    style: TextStyle(fontFamily: "Berlin", letterSpacing: 0.5),
                  )),
            ],
          )),
    );
  }
}
