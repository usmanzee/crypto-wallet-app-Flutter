import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/DepositAddress.dart';
import 'package:crypto_template/models/deposit_histroy.dart';
import 'package:crypto_template/models/withdraw_history.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:get/get.dart';

class TransactionHistoryController extends GetxController {
  final String currency;
  TransactionHistoryController({this.currency});

  var isLoading = true.obs;
  var isDepositHistoryLoading = true.obs;
  var isWithdrawHistoryLoading = true.obs;
  var isAddressLoading = true.obs;
  var depositHistory = List<DepositHistory>().obs;
  var withdrawHistory = List<WithdrawHistory>().obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();
  // WalletRepository _walletRepository;

  @override
  void onInit() {
    // _walletRepository = new WalletRepository();
    // fetchDepositHistory(currency);
    // fetchWithdrawHistory(currency);
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
        var adate = a.createdAt.toLocal();
        var bdate = b.createdAt.toLocal();
        return adate.compareTo(bdate);
      });
      depositHistory.assignAll(depositHistoryResponse);
      withdrawHistory.assignAll(withdrawlHistoryResponse);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  // fetchDepositHistory(String currency) async {
  //   try {
  //     isDepositHistoryLoading(true);
  //     var response = await _walletRepository.fetchDepositHistory(currency);
  //     depositHistory.assignAll(response);
  //     isDepositHistoryLoading(false);
  //   } catch (error) {
  //     print(error);
  //     isDepositHistoryLoading(false);
  //     errorController.handleError(error);
  //   }
  // }

  // fetchWithdrawHistory(String currency) async {
  //   try {
  //     isWithdrawHistoryLoading(true);
  //     var response = await _walletRepository.fetchWithdrawHistory(currency);
  //     print('response');
  //     print(response);
  //     withdrawHistory.assignAll(response);
  //     isWithdrawHistoryLoading(false);
  //   } catch (error) {
  //     print(error);
  //     isWithdrawHistoryLoading(false);
  //     errorController.handleError(error);
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }
}
