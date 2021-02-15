import 'dart:async';
import 'dart:convert';
import 'package:crypto_template/models/formated_market.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketController extends GetxController {
  // final bool withAuth;
  // final FormatedMarket market;
  // WebSocketController({this.withAuth, this.market});

  // final String _baseUrl = "ws://10.121.121.48:9003/api/v2/ranger/public";
  // final String _baseUrl = "wss://www.app.local/";
  // final String _baseUrl = "wss://www.coinee.cf/";
  final String _baseUrl = "wss://ewallet.b4uwallet.com/api/v2/ranger/public";
  final isChannelConnected = false.obs;
  Rx<IOWebSocketChannel> channel;
  Rx<StreamController> streamController;
  var webSocketConnected = false.obs;
  var webSocketConnectionError;

  @override
  void onInit() {
    streamController = StreamController.broadcast().obs;
    connectToWebSocket();
    super.onInit();
  }

  void connectToWebSocket() async {
    final String wsURL = _baseUrl + '/?stream=global.tickers';
    channel = IOWebSocketChannel.connect(wsURL).obs;
    streamController = StreamController.broadcast().obs;
    streamController.value.addStream(channel.value.stream);
  }
  // void connectToWebSocket(bool withAuth, market) async {
  //   var wsAPIVersion = withAuth ? '/private' : '/public';
  //   var url = _baseUrl + wsAPIVersion;
  //   var streams = await streamsBuilder(true, market, true);
  //   final String wsURL =
  //       'ws://10.121.121.48:9003/api/v2/ranger/public/?stream=global.tickers';
  //   // final String wsURL =
  //   //     'wss://ewallet.b4uwallet.com/api/v2/ranger/public/?stream=global.tickers';
  //   var streamURL = generateSocketURI(url, streams);
  //   channel = IOWebSocketChannel.connect(wsURL).obs;
  //   streamController = StreamController.broadcast().obs;
  //   streamController.value.addStream(channel.value.stream);
  // }

  void subscribeOrderBookInc(FormatedMarket market) {
    channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
  }

  void unSubscribeOrderBookInc(FormatedMarket market) {
    channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
  }

  void subscribeKline(FormatedMarket market, String timeValue) {
    channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": ['${market.id}.kline-' + timeValue]
    }));
  }

  void unSubscribeKline(FormatedMarket market, String timeValue) {
    channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": ['${market.id}.kline-' + timeValue]
    }));
  }

  streamsBuilder(
      bool withAuth, FormatedMarket market, bool incrementalOrderBook) {
    var streams = ['global.tickers'];
    if (withAuth) {
      streams = [
        ...streams,
        'order',
        'trade',
      ];
    }
    if (market != null) {
      streams = [
        ...streams,
        ...(marketStreams(market, incrementalOrderBook)['channels']),
      ];
    }

    return streams;
  }

  dynamic marketStreams(FormatedMarket market, incrementalOrderBook) {
    var channels = [
      '${market.id}.trades',
    ];

    if (incrementalOrderBook) {
      return {
        'channels': [
          ...channels,
          '${market.id}.ob-inc',
        ],
      };
    }

    return {
      'channels': [
        ...channels,
        '${market.id}.update',
      ],
    };
  }

  String generateSocketURI(String url, streams) {
    var streamsURL = '';
    for (int i = 0; i < streams.length; i++) {
      streamsURL += (i == 0) ? streams[i] : '&stream=' + streams[i];
    }
    return url + '/?stream=' + streamsURL;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
