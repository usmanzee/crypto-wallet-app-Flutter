import 'package:get/get.dart';
import 'package:b4u_wallet/models/user.dart';

class UserController extends GetxController {
  var user = new User().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
