import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/models/balance.dart';
import 'package:crypto_template/models/currency.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:crypto_template/models/wallet.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletController extends GetxController {
  var isLoading = true.obs;
  var isAddressLoading = true.obs;
  var balancesList = List<Balance>().obs;
  var currenciesList = List<Currency>().obs;
  var walletsList = List<Wallet>().obs;
  // var depositAddress = <DepositAddress>[].obs;
  var depositAddress = ''.obs;
  SnackbarController snackbarController;

  @override
  void onInit() {
    fetchWallets();
    super.onInit();
  }

  void fetchWallets() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isLoading(true);
      var balances = await _walletRepository.fetchBalances();
      var currencies = await _walletRepository.fetchCurrencies();
      balancesList.value = balances;
      currenciesList.value = currencies;
      formateWallets(balances, currencies);

      isLoading(false);
    } catch (error) {
      print(error);
      print(error.errorResponse());
      isLoading(false);
      var errorResponseObj = error.errorResponse();
      snackbarController = new SnackbarController(
          title: 'Error', message: errorResponseObj['message']);
      snackbarController.showSnackbar();
    }
  }

  void formateWallets(List<Balance> balances, List<Currency> currencies) async {
    var wallets = new List<Wallet>();

    for (Currency currency in currencies) {
      var walletInfo =
          balances.where((balance) => balance.currency == currency.id);

      var walletBalance;
      if (walletInfo.isNotEmpty) {
        walletBalance = {
          'currency': currency.id,
          'balance': walletInfo.first.balance,
          'locked': walletInfo.first.locked
        };
      } else {
        walletBalance = {
          'currency': currency.id,
          'balance': '0.00',
          'locked': '0.00'
        };
      }

      var walletsData = new Wallet(
        name: currency.name,
        explorerTransaction: currency.explorerTransaction,
        explorerAddress: currency.explorerAddress,
        fee: currency.withdrawFee,
        type: currency.type,
        fixed: currency.precision,
        iconUrl: currency.iconUrl,
        depositEnabled: currency.depositEnabled,
        withdrawEnabled: currency.withdrawalEnabled,
        precision: currency.precision,
        swapFee: currency.swapFee,
        minSwapAmount: currency.minSwapAmount,
        maxSwapAmount: currency.maxSwapAmount,
        balance: walletBalance['balance'],
        locked: walletBalance['locked'],
        currency: walletBalance['currency'],
      );
      wallets.add(walletsData);
    }
    walletsList.value = wallets;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
