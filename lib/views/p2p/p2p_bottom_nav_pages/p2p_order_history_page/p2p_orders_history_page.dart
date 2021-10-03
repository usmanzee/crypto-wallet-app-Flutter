// import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page_history_page/tabs/completed_tab.dart';
import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page_history_page/tabs/pending_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pOrdersHistoryPage extends StatelessWidget {
  // final _p2pController = Get.find<P2pController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Get.theme.canvasColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 20,
                        color: Get.theme.hintColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        top: 4,
                        bottom: 8,
                      ),
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Get.theme.hintColor, width: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TabBar(
                          labelStyle: TextStyle(
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: Get.theme.hintColor,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          indicatorPadding: const EdgeInsets.only(
                              // top: 6,
                              // bottom: 6,
                              // left: -12,
                              // right: -12,
                              ),
                          indicator: BoxDecoration(
                            color: Get.theme.scaffoldBackgroundColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelColor:
                              Get.theme.textSelectionTheme.selectionColor,
                          unselectedLabelColor: Get.theme.hintColor,
                          tabs: [
                            Tab(
                              text: 'Pending',
                            ),
                            Tab(
                              text: 'Completed',
                            ),
                          ],
                          isScrollable: true,
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: TabBarView(
                    children: [
                      PendingTab(),
                      CompletedTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      initialIndex: 0,
    );
  }
}
