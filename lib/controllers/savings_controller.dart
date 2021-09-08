import 'package:b4u_wallet/models/created_savings_model.dart';
import 'package:b4u_wallet/models/plans_model.dart';
import 'package:b4u_wallet/repository/savings_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'error_controller.dart';

class SavingsController extends GetxController {
  SavingsRepository _savingsRepository = SavingsRepository();
  RxBool isLoading = true.obs;
  RxList<Plans> plansList = <Plans>[].obs;
  RxList<CreatedSavingsModel> createdSavingsList = <CreatedSavingsModel>[].obs;
  RxInt totalPlans = 0.obs;
  RxList<int> flexibleValues = [7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7].obs;
  RxList<bool> switchValue = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ].obs;

  // RxBool switchValue = true.obs;
  ErrorController errorController = ErrorController();
  RxString flexibleSelectedOfferCurrencyName = ''.obs;
  RxString lockedSelectedOfferCurrencyName = ''.obs;
  TextEditingController flexibleOfferController = TextEditingController();
  RxString flexibleSelectedOfferCurrencyAmount = '0'.obs;
  RxString flexibleInterestCalculationTime = '09-07 05:00'.obs;
  RxString flexibleSevenDayApy = '0.5'.obs;
  RxString flexibleYesterdayApy = '0.5'.obs;
  RxBool flexibleCheck = false.obs;
  RxBool creatingInvestment = false.obs;
  RxInt flexiblePlanId = 0.obs;
  RxBool flexibleAutoSubscribe = false.obs;

  Future<void> fetchPlans() async {
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

  Future<void> fetchCreatedSavings() async {
    try {
      List<CreatedSavingsModel> savings =
          await _savingsRepository.fetchCreatedSavings();
      createdSavingsList.assignAll(savings);
    } catch (error) {
      errorController.handleError(error);
    }
  }

  Future<bool> createSavingInvestment({
    @required String status,
    @required int planId,
    @required double amount,
    @required bool autoSubscribe,
  }) async {
    final body = {
      'amount': '$amount',
      'plan_id': '$planId',
      'status': status,
      'auto_subscribe': '$autoSubscribe',
    };
    try {
      creatingInvestment.value = true;
      final res = await _savingsRepository.createSavingInvestment(body);
      creatingInvestment.value = false;
      return res;
    } catch (error) {
      creatingInvestment.value = false;
      errorController.handleError(error);
    }
    return false;
  }

  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    await fetchPlans();
    await fetchCreatedSavings();
    print('hi');
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
