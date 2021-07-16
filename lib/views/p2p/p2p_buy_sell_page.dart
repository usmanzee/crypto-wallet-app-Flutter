import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/components/dialog_widget.dart';
import 'package:b4u_wallet/views/p2p/components/drawer_widget.dart';
import 'package:b4u_wallet/views/p2p/p2p_history_page.dart';
import 'package:b4u_wallet/views/p2p/tabs/p2p_currency_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellPage extends StatelessWidget {
  final List<String> _tabs = <String>[
    'USD',
    'BTC',
    'TRST',
    'ETH',
  ];
  final p2pController = Get.find<P2pController>();

  TabBar get _tabBar => TabBar(
        indicatorColor: Get.theme.primaryColor,
        labelColor: Get.theme.primaryColor,
        unselectedLabelColor: Get.theme.textSelectionTheme.selectionColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: _tabs
            .map((String name) => Tab(
                  text: name,
                ))
            .toList(),
        // isScrollable: true,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        endDrawer: drawerWidget(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  brightness: Brightness.dark,
                  actions: [
                    Container(),
                  ],
                  titleSpacing: 0,
                  toolbarHeight: 96,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) {
                                          return dialogWidget();
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'P2P',
                                          style: TextStyle(
                                            fontFamily: "Popins",
                                            color: Get
                                                .theme.scaffoldBackgroundColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color:
                                              Get.theme.scaffoldBackgroundColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Align(
                                    child: Text(
                                      'UAH',
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        color:
                                            Get.theme.scaffoldBackgroundColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 10),
                                    child: Icon(
                                      Icons.swap_horiz,
                                      size: 20,
                                      color: Get.theme.scaffoldBackgroundColor,
                                    ),
                                  ),
                                  PopupMenuButton(
                                      icon: Icon(Icons.more_horiz),
                                      onSelected: (int value) {
                                        switch (value) {
                                          case 3:
                                            {
                                              Get.toNamed('/p2p_user_profile');
                                            }
                                            break;
                                          case 1:
                                            {
                                              print('from 1');
                                            }
                                            break;
                                          case 2:
                                            {
                                              print('from 2');
                                            }
                                            break;
                                          default:
                                            {
                                              print('from default');
                                            }
                                            break;
                                        }
                                      },
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text('Payment Methods'),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: Text('P2P Help Center'),
                                              value: 2,
                                            ),
                                            PopupMenuItem(
                                              child: Text('P2P User Center'),
                                              value: 3,
                                            ),
                                          ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                            bottom: 4,
                            top: 18,
                          ),
                          decoration: BoxDecoration(
                            color: Get.theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: p2pController.buyOrSellP2p.value
                                          ? null
                                          : () {
                                              p2pController.buyOrSellP2p.value =
                                                  true;
                                            },
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color:
                                              p2pController.buyOrSellP2p.value
                                                  ? Get.theme.textSelectionTheme
                                                      .selectionColor
                                                  : Get.theme.textSelectionTheme
                                                      .selectionColor
                                                      .withOpacity(0.5),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    GestureDetector(
                                      onTap: p2pController.buyOrSellP2p.value
                                          ? () {
                                              p2pController.buyOrSellP2p.value =
                                                  false;
                                            }
                                          : null,
                                      child: Text(
                                        'Sell',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color:
                                              p2pController.buyOrSellP2p.value
                                                  ? Get.theme.textSelectionTheme
                                                      .selectionColor
                                                      .withOpacity(0.5)
                                                  : Get.theme.textSelectionTheme
                                                      .selectionColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to<void>(() => P2pHistoryPage());
                                      },
                                      child: Icon(
                                        Icons.insert_drive_file_outlined,
                                        size: 25,
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      child: Icon(
                                        Icons.filter_alt_outlined,
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
                                            .withOpacity(0.7),
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: Container(
                      width: double.infinity,
                      color: Get.theme.scaffoldBackgroundColor,
                      child: TabBar(
                        indicatorColor: Get.theme.primaryColor,
                        labelColor: Get.theme.primaryColor,
                        unselectedLabelColor:
                            Get.theme.textSelectionTheme.selectionColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Text(
                              'USDT',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'BTC',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'TRST',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'ETH',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Obx(
            () => TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                p2pCurrencyTabWidget(
                    sellList: p2pController.usdSell,
                    buyList: p2pController.usdBuy,
                    name: 'USD'),
                p2pCurrencyTabWidget(
                    sellList: p2pController.btcSell,
                    buyList: p2pController.btcBuy,
                    name: 'BTC'),
                p2pCurrencyTabWidget(
                    sellList: p2pController.trstSell,
                    buyList: p2pController.trstBuy,
                    name: 'TRST'),
                p2pCurrencyTabWidget(
                    sellList: p2pController.ethSell,
                    buyList: p2pController.ethBuy,
                    name: 'ETH'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}