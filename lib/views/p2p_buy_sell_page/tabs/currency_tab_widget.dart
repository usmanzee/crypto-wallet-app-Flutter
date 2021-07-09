import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/p2p_buy_sell_page/container_trade_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final p2pController = Get.find<P2pController>();

Widget currencyTabWidget({
  String name,
  RxList<P2POffer> buyList,
  RxList<P2POffer> sellList,
}) {
  return p2pController.isLoading.value
      ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                MyImgs.testPhoto,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
              Text(
                'No Data',
              ),
            ],
          ),
        )
      : SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(name),
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: Obx(
                      () => SliverFixedExtentList(
                        itemExtent: 210,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return p2pController.buyOrSell.value
                                ? containerTrade(
                                    name: buyList[index].member.email,
                                    price: buyList[index].price,
                                    currency: buyList[index].baseUnit,
                                    bankName: 'MonoBank',
                                    cryptoAmount: '815.98',
                                    functionCallback: () =>
                                        print('function Callback'),
                                    functionText: 'Buy',
                                    lowerLimit: buyList[index].minOrderAmount,
                                    upperLimit: buyList[index].maxOrderAmount,
                                    nameCallback: () =>
                                        print('from name callback'),
                                    reviewPercentage: '98.09',
                                    tabCurrencyName: 'usdt',
                                    trades: '216',
                                    currencySymbol: '\$',
                                  )
                                : containerTrade(
                                    name: sellList[index].member.email,
                                    price: sellList[index].price,
                                    currency: sellList[index].baseUnit,
                                    bankName: 'MonoBank',
                                    cryptoAmount: '815.98',
                                    functionCallback: () =>
                                        print('function Callback'),
                                    functionText: 'Sell',
                                    lowerLimit: sellList[index].minOrderAmount,
                                    upperLimit: sellList[index].maxOrderAmount,
                                    nameCallback: () =>
                                        print('from name callback'),
                                    reviewPercentage: '98.09',
                                    tabCurrencyName: 'usdt',
                                    trades: '216',
                                    currencySymbol: '\$',
                                  );
                          },
                          childCount: p2pController.buyOrSell.value
                              ? buyList.length
                              : sellList.length,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
}
