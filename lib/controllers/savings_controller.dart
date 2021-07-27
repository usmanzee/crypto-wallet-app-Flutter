import 'package:b4u_wallet/models/plans_model.dart';
import 'package:b4u_wallet/repository/savings_repository.dart';
import 'package:get/get.dart';

import 'error_controller.dart';

class SavingsController extends GetxController {
  var isLoading = true.obs;
  var plansList = <Plans>[].obs;
  var totalPlans = 0.obs;
  RxList<int> values = List.from([7,7,7,7,7,7,7],growable: true).obs;
  RxBool switchValue = true.obs;
  ErrorController errorController = ErrorController();

  Future<void> fetchPlans() async {
    SavingsRepository _savingsRepository = SavingsRepository();
    try {
      isLoading.value = true;
      List<Plans> markets = await _savingsRepository.fetchPlans();
      plansList.assignAll(markets);
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      errorController.handleError(error);
    }
  }

  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    await fetchPlans();
    print('hi');
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
