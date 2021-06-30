import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../estimated_widget.dart';
import '../wallet_loading_animation.dart';

class OverviewTab extends StatelessWidget {
  TabController tabController;

  OverviewTab(this.tabController);

  final walletController = Get.find<WalletController>();
  final List<CategoriesWidgetData> dataList = [
    CategoriesWidgetData(icon: Icons.scatter_plot_outlined, name: 'Spot'),
    CategoriesWidgetData(icon: Icons.people_outline, name: 'P2P'),
    CategoriesWidgetData(
        icon: Icons.account_balance_wallet_outlined, name: 'Saving')
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Obx(
                        () {
                          if (walletController.isLoading.value) {
                            return ExtimatedPriceLoadingAnimation(
                              context: context,
                            );
                          } else {
                            return EstimatedWidget();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          /* Container(
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 8.0, bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "wallets.screen.column.currency".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "wallets.screen.column.amount".tr,
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (walletController.isLoading.value)
                  return WalletLoadingAnimation(context: context);
                else
                  return Container(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        return walletList(walletController.walletsList[i], ctx);
                      },
                      itemCount: walletController.walletsList.length,
                    ),
                  );
              }),
            ),*/
          Container(
            height: 5,
            width: double.infinity,
            color: Get.theme.canvasColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Portfolio',
              style: TextStyle(
                fontFamily: "Popins",
                fontSize: 18,
                color: Get.theme.textSelectionTheme.selectionColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    tabController.animateTo(tabController.index+index+1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: categoriesTabs(
                      name: dataList[index].name,
                      icon: dataList[index].icon,
                      value: '0.00 BTC',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesTabs({
    IconData icon,
    String name,
    String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon,color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),),
            SizedBox(width: 6,),
            Text(
              name,
              style: TextStyle(
                fontFamily: "Popins",
                fontSize: 14,
                color: Get.theme.textSelectionTheme.selectionColor.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        //todo: add the values here from the server
        Text(
          '$value BTC',
          style: TextStyle(
            fontFamily: "Popins",
            fontSize: 14,
            color: Get.theme.textSelectionTheme.selectionColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class CategoriesWidgetData {
  IconData icon;

  CategoriesWidgetData({this.icon, this.name});

  String name;
}
