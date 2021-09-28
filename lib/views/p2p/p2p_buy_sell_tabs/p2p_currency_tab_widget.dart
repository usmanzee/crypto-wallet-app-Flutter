import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/utils/Helpers/my_imgs.dart';
import 'package:b4u_wallet/views/p2p/components/p2p_level_check_dialog.dart';
import 'package:b4u_wallet/views/p2p/container_trade_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _p2pController = Get.find<P2pController>();
final _homeController = Get.find<HomeController>();

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
                                        name: buyList[index].name,
                                        price: buyList[index].price,
                                        currency: buyList[index].baseUnit,
                                        bankName: 'MonoBank',
                                        cryptoAmount:
                                            buyList[index].availableAmount,
                                        functionCallback: () {
                                          //fetching the fiat in the asset limit
                                          _p2pController
                                              .fetchAssetAgainstProvidedFiat(
                                            base: buyList[index]
                                                .baseUnit
                                                .toLowerCase(),
                                            quote: buyList[index]
                                                .quoteUnit
                                                .toLowerCase(),
                                            lower: _p2pController
                                                .lowerLimitInAsset,
                                            upper: _p2pController
                                                .upperLimitInAsset,
                                            lowerLimit:
                                                buyList[index].minOrderAmount,
                                            upperLimit:
                                                buyList[index].maxOrderAmount,
                                          );
                                          //fetching the balance
                                          _p2pController
                                              .fetchCurrentQuoteBalance(
                                                  unit:
                                                      buyList[index].baseUnit);
                                          //adding the list to the offer
                                          checkLevel(
                                              offer: buyList[index],
                                              context: context);
                                        },
                                        functionText: buyList[index].side,
                                        lowerLimit:
                                            buyList[index].minOrderAmount,
                                        upperLimit:
                                            buyList[index].maxOrderAmount,
                                        nameCallback: () =>
                                            Get.toNamed('/p2p_user_profile'),
                                        reviewPercentage: buyList[index].rating,
                                        tabCurrencyName:
                                            buyList[index].quoteUnit,
                                        trades: buyList[index]
                                            .totalTrades
                                            .toString(),
                                        currencySymbol:
                                            sellList[index].baseUnit,
                                      )
                                : sellList.length == 0
                                    ? _emptyWidget()
                                    : containerTrade(
                                        name: sellList[index].name,
                                        price: sellList[index].price,
                                        currency: sellList[index].baseUnit,
                                        bankName: 'MonoBank',
                                        cryptoAmount:
                                            sellList[index].availableAmount,
                                        functionCallback: () {
                                          //fetching the fiat in the asset limit
                                          _p2pController
                                              .fetchAssetAgainstProvidedFiat(
                                            quote: sellList[index].quoteUnit,
                                            base: sellList[index].baseUnit,
                                            lower: _p2pController
                                                .lowerLimitInAsset,
                                            upper: _p2pController
                                                .upperLimitInAsset,
                                            lowerLimit:
                                                sellList[index].minOrderAmount,
                                            upperLimit:
                                                sellList[index].maxOrderAmount,
                                          );
                                          //fetching the balance
                                          _p2pController
                                              .fetchCurrentQuoteBalance(
                                            unit: sellList[index].baseUnit,
                                          );
                                          //adding the list to the offer
                                          checkLevel(
                                              offer: sellList[index],
                                              context: context);
                                        },
                                        functionText: sellList[index].side,
                                        lowerLimit:
                                            sellList[index].minOrderAmount,
                                        upperLimit:
                                            sellList[index].maxOrderAmount,
                                        nameCallback: () =>
                                            print('from name callback'),
                                        reviewPercentage:
                                            sellList[index].rating,
                                        tabCurrencyName:
                                            sellList[index].quoteUnit,
                                        trades: sellList[index]
                                            .totalTrades
                                            .toString(),
                                        currencySymbol:
                                            sellList[index].baseUnit,
                                      );
                          },
                          childCount: _p2pController.buyOrSellP2p.value
                              ? buyList.length == 0
                                  ? 1
                                  : buyList.length
                              : sellList.length == 0
                                  ? 1
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

void checkLevel({@required P2POffer offer, @required BuildContext context}) {
  if (_homeController.user.value.level >=
      _homeController.publicMemberLevel.value.trading.minimumLevel) {
    _p2pController.selectedOffer = offer;
    Get.toNamed('/p2p_buy_sell_selected_offer_page');
  } else {
    p2pLevelCheckDialog(context: context);
  }
}

Widget _emptyWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    // mainAxisSize: MainAxisSize.min,
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
