import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/models/deposit_histroy_response.dart';
import 'package:b4u_wallet/models/withdraw_history_response.dart';
import 'package:b4u_wallet/repository/wallet_repository.dart';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionHistoryController extends GetxController {
  final String currency;
  TransactionHistoryController({this.currency});

  var fetchingDepositHistory = false.obs;
  var fetchingWithdrawHistory = false.obs;
  var isAddressLoading = true.obs;
  var depositHistory = <DepositHistoryResponse>[].obs;
  var withdrawHistory = <WithdrawHistoryResponse>[].obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find();

  @override
  void onInit() async {
    fetchingDepositHistory(true);
    fetchingWithdrawHistory(true);
    await Future.delayed(Duration(seconds: 2));
    await homeController.fetchMemberLevels();
    if (!homeController.fetchingMemberLevel.value &&
        !homeController.publicMemberLevel.value.isBlank) {
      if (homeController.user.value.level >=
          homeController.publicMemberLevel.value.deposit.minimumLevel) {
        fetchDepositHistory(currency);
      } else {
        fetchingDepositHistory(false);
      }
      if (homeController.user.value.level >=
          homeController.publicMemberLevel.value.withdraw.minimumLevel) {
        fetchWithdrawHistory(currency);
      } else {
        fetchingWithdrawHistory(false);
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void fetchDepositHistory(currency) async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      fetchingDepositHistory(true);
      var depositHistoryResponse =
          await _walletRepository.fetchDepositHistory(currency);
      depositHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });
      depositHistory.assignAll(depositHistoryResponse);

      fetchingDepositHistory(false);
    } catch (error) {
      fetchingDepositHistory(false);
      errorController.handleError(error);
    }
  }

  void fetchWithdrawHistory(currency) async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      fetchingWithdrawHistory(true);
      var withdrawlHistoryResponse =
          await _walletRepository.fetchWithdrawHistory(currency);
      withdrawlHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });
      withdrawHistory.assignAll(withdrawlHistoryResponse);
      fetchingWithdrawHistory(false);
    } catch (error) {
      fetchingWithdrawHistory(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
