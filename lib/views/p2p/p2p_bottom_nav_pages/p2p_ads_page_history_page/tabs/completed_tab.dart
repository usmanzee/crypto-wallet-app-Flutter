import 'package:b4u_wallet/views/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
      ),
      child: DefaultTabController(
        length: 3,
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
                    text: 'Completed',
                  ),
                  Tab(
                    text: 'Canceled',
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
                  //todo: showing empty widgets for now
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
