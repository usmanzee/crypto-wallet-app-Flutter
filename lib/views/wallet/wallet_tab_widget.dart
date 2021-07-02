import 'package:b4u_wallet/models/wallet.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'headerWidget.dart';

Widget WalletTabWidget({String estimatedValueSecondary, String estimatedValue, List<Wallet> walletsList}){
  return SafeArea(
    child: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return headerWidget(firstValue: estimatedValueSecondary,secondValue: estimatedValue);
            },
            childCount: 1,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: Delegate(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return walletList(walletsList[index]);
            },
            childCount: walletsList.length,
          ),
        ),
      ],
    ),
  );
}

// a custom delegate for implementing a sticky header.
class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  //todo: add the callback here for hiding the 0 balances...
                  print('yeah');
                },
                child: Icon(
                  Icons.check_circle,
                  color: Get.theme.textSelectionTheme.selectionColor
                      .withOpacity(0.7),
                  size: 20,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Hide 0 Balances',
                style: TextStyle(
                  fontFamily: "Popins",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.textSelectionTheme.selectionColor
                      .withOpacity(0.7),
                ),
              ),
            ],
          ),
          //todo: add the functionality to display the search bar
          Icon(
            Icons.search,
            color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.7),
            size: 25,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

//list variables
Widget walletList(
    Wallet wallet,
    ) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            // todo: take to the new screen for that currency
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                      child: wallet.iconUrl != null
                          ? Image.network(
                        wallet.iconUrl,
                        height: 25.0,
                        fit: BoxFit.contain,
                        width: 22.0,
                      )
                          : Image.asset(
                        MyImgs.testPhoto,
                        height: 22.0,
                        fit: BoxFit.contain,
                        width: 22.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          wallet.currency.toUpperCase(),
                          style:
                          TextStyle(fontFamily: "Popins", fontSize: 16.5),
                        ),
                        Text(
                          wallet.name,
                          style: TextStyle(
                              fontFamily: "Popins",
                              fontSize: 11.5,
                              color: Get.theme.hintColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        (double.parse(wallet.balance) +
                            double.parse(wallet.locked))
                            .toStringAsFixed(wallet.type == 'fiat' ? 2 : 6),
                        style: TextStyle(
                            fontFamily: "Popins",
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
          child: Container(
            width: double.infinity,
            height: 0.5,
            decoration:
            BoxDecoration(color: Get.theme.hintColor.withOpacity(0.1)),
          ),
        ),
      ],
    ),
  );
}
