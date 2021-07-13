import 'dart:async';

import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/repository/p2p_repository.dart';
import 'package:get/get.dart';

class P2pController extends GetxController {
  ErrorController errorController = ErrorController();
  RxBool isLoading = true.obs;

  //buy or sell page or express page
  RxBool buySellOrExpress = false.obs;

  // true means buy and false means sell
  RxBool buyOrSellP2p = true.obs;
  RxBool buyOrSellExpress = true.obs;

  // history filets
  RxString typeSelected = 'All'.obs;
  RxString statusSelected = 'All'.obs;

  //profile page
  RxInt user30DaysTrades = 0.obs;
  RxInt averageReleaseTime = 0.obs;
  RxInt averagePayTime = 0.obs;
  RxDouble user30DaysCompletionRate = 0.00.obs;

  /* RxList<P2POffer> p2pOffersBuy = <P2POffer>[].obs;
  RxList<P2POffer> p2pOffersSell = <P2POffer>[].obs;*/
  //usdt list
  RxList<P2POffer> usdBuy = <P2POffer>[].obs;
  RxList<P2POffer> usdSell = <P2POffer>[].obs;

  //btc list
  RxList<P2POffer> btcBuy = <P2POffer>[].obs;
  RxList<P2POffer> btcSell = <P2POffer>[].obs;

  //trst list
  RxList<P2POffer> trstBuy = <P2POffer>[].obs;
  RxList<P2POffer> trstSell = <P2POffer>[].obs;

  //usdt list
  RxList<P2POffer> ethBuy = <P2POffer>[].obs;
  RxList<P2POffer> ethSell = <P2POffer>[].obs;

  //express transaction by crypto or cash, true means by crypto and false means by cash
  RxBool cryptoOrCash = true.obs;

  //controllers for the

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    fetchAllLists();
    // fetchP2pOffers();
    super.onInit();
  }

  void fetchAllLists() async {
    isLoading(true);
    await fetchP2pOffers(
        category: 'usd', buyList: usdBuy, sellList: usdSell);
   await fetchP2pOffers(
        category: 'eth', buyList: ethBuy, sellList: ethSell);
    await fetchP2pOffers(
        category: 'trst', buyList: trstBuy, sellList: trstSell);
    await fetchP2pOffers(
        category: 'btc', buyList: btcBuy, sellList: btcSell);
    isLoading(false);
  }

  Future<bool> fetchP2pOffers({
    String category,
    RxList<P2POffer> buyList,
    RxList<P2POffer> sellList,
  }) async {
    // isLoading(true);
    P2pRepository _p2pRepository = P2pRepository();
    try {
      final response = await _p2pRepository.fetchP2pOffers(category: category);
      if (response.length > 0) {
        response.forEach((e) {
          e.side == 'buy' ? buyList.add(e) : sellList.add(e);
        });
        // isLoading(false);
        return true;
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);

      return false;
    }
  }
}
