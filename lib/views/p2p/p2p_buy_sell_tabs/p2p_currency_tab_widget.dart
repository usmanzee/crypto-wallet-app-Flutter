import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/p2p/components/p2p_level_check_dialog.dart';
import 'package:b4u_wallet/views/p2p/container_trade_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _p2pController = Get.find<P2pController>();

//todo: add the all of the missing required variables
Widget p2pCurrencyTabWidget({
  String name,
  RxList<P2POffer> buyList,
  RxList<P2POffer> sellList,
}) {
  return _p2pController.isLoading.value
      ? Center(
          child: Center(
            child: CircularProgressIndicator(),
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
                            return _p2pController.buyOrSellP2p.value
                                ? buyList.length == 0
                                    ? _emptyWidget()
                                    : containerTrade(
                                        name: 'buyList[index]',
                                        price: buyList[index].price,
                                        currency: buyList[index].baseUnit,
                                        bankName: 'MonoBank',
                                        cryptoAmount: '815.98',
                                        functionCallback: () {
                                          // Get.toNamed(
                                          //     '/P2p_buy_sell_selected_offer_page');
                                          //todo: remove the link to the next page and add the check for the level
                                          p2pLevelCheckDialog(context: context);
                                        },
                                        functionText: buyList[index].side,
                                        lowerLimit:
                                            buyList[index].minOrderAmount,
                                        upperLimit:
                                            buyList[index].maxOrderAmount,
                                        nameCallback: () =>
                                            Get.toNamed('/p2p_user_profile'),
                                        reviewPercentage: 'none',
                                        tabCurrencyName: 'usdt',
                                        trades: 'none',
                                        currencySymbol: '',
                                      )
                                : sellList.length == 0
                                    ? _emptyWidget()
                                    : containerTrade(
                                        name: 'sellList[index]',
                                        price: sellList[index].price,
                                        currency: sellList[index].baseUnit,
                                        bankName: 'MonoBank',
                                        cryptoAmount:
                                            sellList[index].availableAmount,
                                        functionCallback: () {
                                          p2pLevelCheckDialog(context: context);
                                        },
                                        functionText: sellList[index].side,
                                        lowerLimit:
                                            sellList[index].minOrderAmount,
                                        upperLimit:
                                            sellList[index].maxOrderAmount,
                                        nameCallback: () =>
                                            print('from name callback'),
                                        reviewPercentage: '98.09',
                                        tabCurrencyName: 'usdt',
                                        trades: '216',
                                        currencySymbol: '\$',
                                      );
                          },
                          childCount: _p2pController.buyOrSellP2p.value
                              ? buyList.length == 0 ? 1 : buyList.length
                              : sellList.length == 0 ? 1 : sellList.length,
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

Widget _emptyWidget() {
  return Column(
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
  );
}
