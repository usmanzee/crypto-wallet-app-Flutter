import 'package:get/get.dart';

class P2pController extends GetxController{

  RxBool isLoading = true.obs;
  // true means buy and false means sell
  RxBool buyOrSell = true.obs;
  RxString typeSelected = 'All'.obs;
  RxString statusSelected = 'All'.obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }
}