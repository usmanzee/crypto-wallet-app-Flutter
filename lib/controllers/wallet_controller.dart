import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/models/balance.dart';
import 'package:b4u_wallet/models/currency.dart';
import 'package:b4u_wallet/repository/wallet_repository.dart';
import 'package:b4u_wallet/models/wallet.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var isLoading = false.obs;
  var isAddressLoading = false.obs;
  var balancesList = List<Balance>().obs;
  var currenciesList = List<Currency>().obs;
  var walletsList = List<Wallet>().obs;
  var searchWalletsList = List<Wallet>().obs;
  // var depositAddress = <DepositAddress>[].obs;
  var depositAddress = ''.obs;
  ErrorController errorController = new ErrorController();
  MarketController marketController = Get.find<MarketController>();
  HomeController homeController = Get.find<HomeController>();
  var iconC = 'BTC'.obs;

  @override
  void onInit() {
    if (homeController.isLoggedIn.value) {
      fetchWallets();
    }
    ever(homeController.isLoggedIn, fetchWalletsValues);
    super.onInit();
  }

  fetchWalletsValues(isLoggedIn) {
    fetchWallets();
  }

  void fetchWallets() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isLoading(true);
      var balances = await _walletRepository.fetchBalances();
      var currencies = await _walletRepository.fetchCurrencies();
      balancesList.assignAll(balances);
      currenciesList.assignAll(currencies);
      var wallets = await formateWallets(balances, currencies);
      walletsList.assignAll(wallets);
      searchWalletsList.assignAll(wallets);

      isLoading(false);
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  Future<List<Wallet>> formateWallets(
      List<Balance> balances, List<Currency> currencies) async {
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

      var walletData = new Wallet(
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
      wallets.add(walletData);
    }
    return wallets;
  }

  void handleSearchInputChangeEvent(String value) {
    var list = walletsList.where((wallet) {
      return wallet.name.toLowerCase().contains(value.toLowerCase()) ||
          wallet.currency.toLowerCase().contains(value.toLowerCase());
    });
    searchWalletsList.assignAll(list);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
