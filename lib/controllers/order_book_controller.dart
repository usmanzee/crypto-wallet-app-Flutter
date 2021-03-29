import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/web_socket_controller.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:b4u_wallet/utils/Helpers/ws_helper.dart';

class OrderBookController extends GetxController {
  final market;
  OrderBookController({this.market});
  var bids = List<dynamic>().obs;
  var asks = List<dynamic>().obs;
  var bidsData = List<DepthEntity>().obs;
  var asksData = List<DepthEntity>().obs;

  MarketController marketController = Get.find();
  WebSocketController webSocketController = Get.find();

  ErrorController errorController = new ErrorController();

  @override
  void onInit() async {
    // market.value = marketController.selectedMarket.value;

    // getWSStreams();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getWSStreams() {
    webSocketController.channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
    webSocketController.streamController.value.stream.listen((message) {
      var data = json.decode(message);
      print(data);
      if (data.containsKey('${market.id}.ob-snap')) {
        asks.assignAll(data['${market.id}.ob-snap']['asks']);
        bids.assignAll(data['${market.id}.ob-snap']['bids']);
      }
      if (data.containsKey('${market.id}.ob-inc')) {
        var updatedAsksData = [];
        var updatedBidsData = [];
        if (data['${market.id}.ob-inc']['asks'] != null) {
          var asks = data['${market.id}.ob-inc']['asks'];
          if (WsHelper.isArray(asks[0].toString())) {
            for (var i = 0; i < asks.length; i++) {
              updatedAsksData =
                  WsHelper.handleIncrementalUpdate(asks, asks[i], 'asks');
            }
          } else {
            updatedAsksData =
                WsHelper.handleIncrementalUpdate(asks, asks, 'asks');
          }

          updatedAsksData = updatedAsksData.length >= 10
              ? updatedAsksData.sublist(0, 10)
              : updatedAsksData;
          asks.assignAll(updatedAsksData);
          asks.refresh();
        }
        if (data['${market.id}.ob-inc']['bids'] != null) {
          var bids = data['${market.id}.ob-inc']['bids'];
          if (WsHelper.isArray(bids[0].toString())) {
            for (var i = 0; i < bids.length; i++) {
              updatedBidsData =
                  WsHelper.handleIncrementalUpdate(bids, bids[i], 'bids');
            }
          } else {
            updatedBidsData =
                WsHelper.handleIncrementalUpdate(bids, bids, 'bids');
          }
          updatedBidsData = updatedBidsData.length >= 10
              ? updatedBidsData.sublist(0, 10)
              : updatedBidsData;
          bids.assignAll(updatedBidsData);
          bids.refresh();
        }
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  @override
  void onClose() {
    // webSocketController.channel.value.sink.add(json.encode({
    //   "event": "unsubscribe",
    //   "streams": [
    //     '${market.id}.ob-inc',
    //   ]
    // }));
    super.onClose();
  }
}
