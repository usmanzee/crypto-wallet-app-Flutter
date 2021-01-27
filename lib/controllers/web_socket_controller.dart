import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketController extends GetxController {
  final isChannelConnected = false.obs;
  var channel = ''.obs;
  var webSocketConnected = false.obs;
  var webSocketConnectionError;
  @override
  void onInit() {
    connectToWebSocket();
    super.onInit();
  }

  void connectToWebSocket() {
    print("trying to connect to websocket");

    final Future futureChannel = establishConnection();
    futureChannel.then((future) {
      print("Connection established, registering interest now...");
      channel.value = future;
      webSocketConnected(true);
    }).catchError((error) {
      channel.value = null;
      webSocketConnected(false);
      webSocketConnectionError = error.toString();
      print("WS Connection failed \n $webSocketConnectionError");
    });
  }

  Future<IOWebSocketChannel> establishConnection() async {
    final IOWebSocketChannel channel = IOWebSocketChannel.connect(
        'wss://ewallet.b4uwallet.com/api/v2/ranger/public/?stream=global.tickers');
    return channel;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
