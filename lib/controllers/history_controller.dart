import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/SnackbarController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/models/deposit_histroy_response.dart';
import 'package:b4u_wallet/models/trade_histroy_response.dart';
import 'package:b4u_wallet/models/withdraw_history_response.dart';
import 'package:b4u_wallet/repository/wallet_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  var isLoading = false.obs;
  var isDepositHistoryLoading = false.obs;
  var isWithdrawHistoryLoading = false.obs;
  var isTradeHistoryLoading = false.obs;
  var depositHistory = <DepositHistoryResponse>[].obs;
  var withdrawHistory = <WithdrawHistoryResponse>[].obs;
  var tradeHistory = <TradeHistoryResponse>[].obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() async {
    isDepositHistoryLoading(true);
    isWithdrawHistoryLoading(true);
    isTradeHistoryLoading(true);
    await Future.delayed(Duration(seconds: 2));
    await homeController.fetchMemberLevels();
    if (!homeController.fetchingMemberLevel.value &&
        !homeController.publicMemberLevel.value.isBlank) {
      if (homeController.user.value.level >=
          homeController.publicMemberLevel.value.deposit.minimumLevel) {
        fetchDepositHistory();
      } else {
        isDepositHistoryLoading(false);
      }
      if (homeController.user.value.level >=
          homeController.publicMemberLevel.value.withdraw.minimumLevel) {
        fetchWithdrawHistory();
      } else {
        isWithdrawHistoryLoading(false);
      }
      if (homeController.user.value.level >=
          homeController.publicMemberLevel.value.trading.minimumLevel) {
        fetchTradeHistory();
      } else {
        isTradeHistoryLoading(false);
      }
    }
    // ever(homeController.fetchingMemberLevel, fetchHistory);
    super.onInit();
  }

  fetchHistory(bool isMemberLevelFetched) {
    if (!isMemberLevelFetched &&
        !homeController.publicMemberLevel.value.isBlank) {
      fetchDepositHistory();
      fetchWithdrawHistory();
      fetchTradeHistory();
    }
  }

  void fetchDepositHistory() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isDepositHistoryLoading(true);
      var depositHistoryResponse =
          await _walletRepository.fetchDepositHistory('');

      depositHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });

      depositHistory.assignAll(depositHistoryResponse);
      isDepositHistoryLoading(false);
    } catch (error) {
      isDepositHistoryLoading(false);
      errorController.handleError(error);
    }
  }

  void fetchWithdrawHistory() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isWithdrawHistoryLoading(true);
      var withdrawlHistoryResponse =
          await _walletRepository.fetchWithdrawHistory('');

      withdrawlHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });

      withdrawHistory.assignAll(withdrawlHistoryResponse);
      isWithdrawHistoryLoading(false);
    } catch (error) {
      isWithdrawHistoryLoading(false);
      errorController.handleError(error);
    }
  }

  void fetchTradeHistory() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isTradeHistoryLoading(true);
      var tradeHistoryResponse = await _walletRepository.fetchTradeHistory('');

      tradeHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });
      tradeHistory.assignAll(tradeHistoryResponse);
      isTradeHistoryLoading(false);
    } catch (error) {
      isTradeHistoryLoading(false);
      errorController.handleError(error);
    }
  }

  Future<Null> refreshDepositHistory() async {
    fetchDepositHistory();
  }

  Future<Null> refreshWithdrawlHistory() async {
    fetchWithdrawHistory();
  }

  Future<Null> refreshTradeHistory() async {
    fetchTradeHistory();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
