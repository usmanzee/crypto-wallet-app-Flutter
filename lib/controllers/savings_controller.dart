import 'package:b4u_wallet/models/plans_model.dart';
import 'package:b4u_wallet/repository/savings_repository.dart';
import 'package:get/get.dart';

import 'error_controller.dart';

class SavingsController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Plans> plansList = <Plans>[].obs;
  RxInt totalPlans = 0.obs;
  RxList<int> flexibleValues = [7,7,7,7,7,7,7,7,7,7,7,7].obs;
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
