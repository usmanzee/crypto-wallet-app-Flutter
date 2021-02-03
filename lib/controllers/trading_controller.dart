import 'package:crypto_template/controllers/market_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:get/get.dart';

class TradingController extends GetxController {
  // final FormatedMarket formatedMarket = Get.arguments['formatedMarket'];
  var market = FormatedMarket().obs;
  MarketController marketController = Get.find();
  @override
  void onInit() async {
    market.value = marketController.formatedMarketsList[0];
    super.onInit();
  }

  @override
  void onReady() {
    // marketController.streamController.value.stream.listen((data) {
    //   // print("DataReceived1: " + data);
    // }, onDone: () {
    //   print("Task Done1");
    // }, onError: (error) {
    //   print("Some Error1");
    // });
    super.onReady();
  }

  void updateCurrentMarket(FormatedMarket newMarket) {
    market.value = newMarket;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
