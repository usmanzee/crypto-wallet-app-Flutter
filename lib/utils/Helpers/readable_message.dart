import 'package:crypto_template/utils/server_messages_data.dart';

class ReadAbleMessage {
  final String message;

  ReadAbleMessage({this.message});

  getMessage() {
    String serverMessage = serverMessages[this.message];
    return serverMessage != null ? serverMessage : this.message;
  }
}
