import 'dart:async';
import 'package:crypto_template/models/notification_response.dart';
import 'package:crypto_template/network/api_provider.dart';

class NotificationRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<List<NotificationResponse>> fetchNotifications() async {
    final response = await apiProvider.get('peatio/account/notifications');
    return notificationResponseFromJson(response);
  }
}
