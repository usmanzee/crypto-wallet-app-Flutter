import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/deposit_histroy_response.dart';
import 'package:crypto_template/models/withdraw_history_response.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionHistoryController extends GetxController {
  final String currency;
  TransactionHistoryController({this.currency});

  var isLoading = true.obs;
  var isDepositHistoryLoading = true.obs;
  var isWithdrawHistoryLoading = true.obs;
  var isAddressLoading = true.obs;
  var depositHistory = List<DepositHistoryResponse>().obs;
  var withdrawHistory = List<WithdrawHistoryResponse>().obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  @override
  void onInit() {
    fetchHistory(currency);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchHistory(currency) async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isLoading(true);
      var depositHistoryResponse =
          await _walletRepository.fetchDepositHistory(currency);
      var withdrawlHistoryResponse =
          await _walletRepository.fetchWithdrawHistory(currency);
      depositHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });
      depositHistory.assignAll(depositHistoryResponse);
      withdrawHistory.assignAll(withdrawlHistoryResponse);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
