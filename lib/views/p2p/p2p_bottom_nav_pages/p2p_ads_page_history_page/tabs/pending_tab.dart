import 'package:b4u_wallet/views/p2p/p2p_bottom_nav_pages/p2p_ads_page_history_page/tabs/pending_tabs_pages/all_payment_tab.dart';
import 'package:b4u_wallet/views/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
      ),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                indicatorColor: Get.theme.accentColor,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Get.theme.textSelectionTheme.selectionColor,
                unselectedLabelColor: Get.theme.hintColor,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Unpaid',
                  ),
                  Tab(
                    text: 'Paid',
                  ),
                  Tab(
                    text: 'Appeal Pending',
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Get.theme.hintColor,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllPaymentTab(),
                  EmptyWidget(),
                  EmptyWidget(),
                  EmptyWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
