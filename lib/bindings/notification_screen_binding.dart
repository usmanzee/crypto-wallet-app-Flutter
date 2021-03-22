import 'package:crypto_template/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
