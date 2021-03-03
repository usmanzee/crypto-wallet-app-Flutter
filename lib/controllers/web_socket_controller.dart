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

  // final String _baseUrl = "ws://10.121.12.231:9003/api/v2/ranger/public";
  // final String _baseUrl = "wss://www.app.local/";
  final String _baseUrl = "wss://www.coinee.cf/api/v2/ranger/public";
  // final String _baseUrl = "wss://ewallet.b4uwallet.com/api/v2/ranger/public";
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
    // streamController = StreamController.broadcast().obs;
    // streamController.value.addStream(channel.value.stream);

    channel.value.stream.listen((event) {
      streamController.value.add(event);
    }, onError: (e) async {
      print('error');
      await Future.delayed(Duration(seconds: 3));
      connectToWebSocket();
    }, onDone: () async {
      print('on done');
      await Future.delayed(Duration(seconds: 3));
      connectToWebSocket();
    }, cancelOnError: true);
  }

  Future<void> subscribeOrderBookInc(FormatedMarket market) async {
    channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
  }

  Future<void> unSubscribeOrderBookInc(FormatedMarket market) async {
    channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
  }

  Future<void> subscribeKline(FormatedMarket market, String timeValue) async {
    channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": ['${market.id}.kline-' + timeValue]
    }));
  }

  Future<void> unSubscribeKline(FormatedMarket market, String timeValue) async {
    channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": ['${market.id}.kline-' + timeValue]
    }));
  }

  Future<void> subscribeOrder() async {
    channel.value.sink.add(json.encode({
      "event": "subscribe",
      "streams": ['order']
    }));
  }

  Future<void> unSubscribeOrder() async {
    channel.value.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": ['order']
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
