import 'dart:async';
import 'package:b4u_wallet/models/notification_response.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/network/request_headers.dart';

class NotificationRepository {
  ApiProvider apiProvider;

  Future<List<NotificationResponse>> fetchNotifications() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/notifications');
    return notificationResponseFromJson(response);
  }
}
