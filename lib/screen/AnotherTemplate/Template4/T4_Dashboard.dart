import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_Custom_nav_bar.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_banking.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_home.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_setting.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_transactions.dart';
import 'package:crypto_template/screen/AnotherTemplate/Template4/T4_wallet.dart';
import 'package:crypto_template/screen/home/home.dart';
import 'package:crypto_template/screen/market/markets.dart';
import 'package:crypto_template/screen/news/news_home.dart';
import 'package:crypto_template/screen/wallet/wallet.dart';
import 'package:flutter/material.dart';

class T4_dashboard extends StatefulWidget {
  T4_dashboard({Key key}) : super(key: key);

  _T4_dashboardState createState() => _T4_dashboardState();
}

class _T4_dashboardState extends State<T4_dashboard> {


  int currentIndex = 0;
  bool _color =true;
  Widget callPage(int current){
    switch (current) {
       case 0:
        return new T4_home();
        break;
      case 1:
      return new T4_transactions();
        break;
      case 2:
      return new T4_banking();
        break;
        case 3:
      return new T4_wallet();
        break;
        case 4:
        return new T4_setting();
        break;
      default: 
      return new T4_home();
    }
  }

 
   @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
       body: callPage(currentIndex),


        bottomNavigationBar: T4_BottomNavigationDotBar ( // Usar -> "T4_BottomNavigationDotBar"
        color: Colors.black12,
      items: <T4_BottomNavigationDotBarItem>[
        T4_BottomNavigationDotBarItem(icon: Icons.home, onTap: () { setState(() {
         currentIndex = 0;
        }); }),
        T4_BottomNavigationDotBarItem(icon: Icons.confirmation_number, onTap: () { setState(() {
         currentIndex = 1;
        }); }),
        T4_BottomNavigationDotBarItem(icon: Icons.account_balance, onTap: () { setState(() {
         currentIndex = 2;
        }); }),
         T4_BottomNavigationDotBarItem(icon: Icons.account_balance_wallet, onTap: () { setState(() {
         currentIndex = 3;
        }); }),  
         T4_BottomNavigationDotBarItem(icon: Icons.settings, onTap: () { setState(() {
         currentIndex = 4;
        }); }), 
         ]
  ),

    );
  }
}