import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/wallet/estimated_widget.dart';
import 'package:b4u_wallet/views/wallet/tabs/overview_tab.dart';
import 'package:b4u_wallet/views/wallet/tabs/spot_tab.dart';
import 'package:b4u_wallet/views/wallet/wallet_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:b4u_wallet/models/wallet.dart' as WalletClass;
import 'package:get/get.dart';

class Wallets extends StatefulWidget {
  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> with SingleTickerProviderStateMixin {
  final walletController = Get.put(WalletController());
  TabController _tabController;
  final MarketController marketController = Get.find<MarketController>();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        foregroundColor: Get.theme.textSelectionTheme.selectionColor,
        // centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Overview',
              ),
            ),
            Tab(
              child: Text(
                'Spot',
              ),
            ),
            Tab(
              child: Text(
                'P2P',
              ),
            ),
            Tab(
              child: Text(
                'Saving',
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewTab(_tabController),
          SpotTab(),
          // P2PTab(),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}

Widget walletList(WalletClass.Wallet wallet, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Get.toNamed('/wallet-detail', arguments: {'wallet': wallet});
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
                              //todo: get the icons from the server
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
                              color: Theme.of(ctx).hintColor),
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
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 19.0,
                      )
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
                BoxDecoration(color: Theme.of(ctx).hintColor.withOpacity(0.1)),
          ),
        )
      ],
    ),
  );
}
