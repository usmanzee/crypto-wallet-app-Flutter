import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/help_center_tabs/advanced_tab.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/help_center_tabs/advertiser_tab.dart';
import 'package:b4u_wallet/views/p2p/p2p_user_profile/help_center_tabs/beginner_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pHelpCanterPage extends StatelessWidget {
  final List<String> _tabs = <String>[
    'Beginner',
    'Advanced',
    // 'Advertiser',
  ];
  final p2pController = Get.find<P2pController>();

  TabBar get _tabBar => TabBar(
        indicatorColor: Get.theme.primaryColor,
        labelColor: Get.theme.primaryColor,
        unselectedLabelColor: Get.theme.hintColor,
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
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  elevation: 0,
                  brightness: Brightness.dark,
                  actions: [
                    Container(),
                  ],
                  titleSpacing: 0,
                  toolbarHeight: 100,
                  expandedHeight: 150,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      // bottom: 12,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap:  () => Get.back(),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Get.theme.scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                        Text(
                          'P2P Help Center',
                          style: TextStyle(),
                        ),
                        Text(
                          '24/7 online customer Support',
                          style: TextStyle(),
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
                        unselectedLabelColor: Get.theme.hintColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        tabs: _tabBar.tabs,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: [
              BeginnerTab(),
              AdvancedTab(),
              // AdvertiserTab(),
            ],
          ),
        ),
      ),
    );
  }
}
