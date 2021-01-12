import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/notification_response.dart';
import 'package:crypto_template/repository/notification_repository.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var isLoading = true.obs;
  var notificationList = List<NotificationResponse>().obs;
  ErrorController errorController = new ErrorController();

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  void fetchNotifications() async {
    NotificationRepository _notificationRepository =
        new NotificationRepository();
    try {
      isLoading(true);
      var notifications = await _notificationRepository.fetchNotifications();
      notificationList.assignAll(notifications);
      isLoading(false);
    } catch (error) {
      print(error);
      isLoading(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
