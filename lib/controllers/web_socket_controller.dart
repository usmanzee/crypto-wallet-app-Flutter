import 'dart:async';
import 'dart:convert';
import 'package:b4u_wallet/models/formated_market.dart';
import 'package:b4u_wallet/utils/Helpers/environment.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

class WebSocketController extends GetxController {
  final String _baseUrl = Environment.getWSBaseUrl();
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
    final String wsURL = _baseUrl + '?stream=global.tickers';
    print('here is the url $wsURL');
    channel = IOWebSocketChannel.connect(wsURL).obs;
    // streamController = StreamController.broadcast().obs;
    // streamController.value.addStream(channel.value.stream);

    channel.value.stream.listen((event) {
      streamController.value.add(event);
    }, onError: (e) async {
      print('Error while connecting websocket, Reconnecting...');
      await Future.delayed(Duration(seconds: 3));
      connectToWebSocket();
    }, onDone: () async {
      print('Reconnecting websocket...');
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
      //todo: change it before committing
      // "streams": ['${market.id}.kline-' + timeValue]
      "streams": ['chat']
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
