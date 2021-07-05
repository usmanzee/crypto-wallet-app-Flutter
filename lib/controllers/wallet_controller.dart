import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/models/balance.dart';
import 'package:b4u_wallet/models/currency.dart';
import 'package:b4u_wallet/models/wallet.dart';
import 'package:b4u_wallet/repository/wallet_repository.dart';
import 'package:b4u_wallet/utils/Helpers/estimate_value.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAddressLoading = false.obs;
  RxList<Balance> balancesList = <Balance>[].obs;
  RxList<Balance> p2pList = <Balance>[].obs;
  RxList<Balance> savingList = <Balance>[].obs;
  RxList<Currency> currenciesList = <Currency>[].obs;
  RxList<Wallet> walletsList = <Wallet>[].obs;
  RxList<Wallet> savingWalletsList = <Wallet>[].obs;
  RxList<Wallet> p2pWalletsList = <Wallet>[].obs;
  RxBool visibility = true.obs;

  RxList<Wallet> searchWalletsList = <Wallet>[].obs;
  // var depositAddress = <DepositAddress>[].obs;
  RxString depositAddress = ''.obs;
  ErrorController errorController = ErrorController();
  MarketController marketController = Get.find<MarketController>();
  HomeController homeController = Get.find<HomeController>();
  var iconC = 'BTC'.obs;
  // estimated values for the wallets tabs
  RxDouble estimatedValueUSDAll = 0.00.obs;
  RxString estimatedValueAll = '0.0000'.obs;
  RxDouble estimatedValueUsdP2p = 0.00.obs;
  RxString estimatedValueP2p = '0.0000'.obs;
  RxDouble estimatedValueUsdSaving = 0.00.obs;
  RxString estimatedValueSaving = '0.0000'.obs;
  RxDouble estimatedValueUsdSpot = 0.00.obs;
  RxString estimatedValueSpot = '0.0000'.obs;
  @override
  void onInit() async{
    if (homeController.isLoggedIn.value){
      fetchWallets();
    }
    ever(homeController.isLoggedIn, fetchWalletsValues);
    super.onInit();
  }

  fetchWalletsValues(isLoggedIn) {
    fetchWallets();
    // fetchP2pTotalEstimate();
  }

  void fetchWallets() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isLoading(true);
      //fetching balances from the all three lists.
      List<Balance> spotBalances = await _walletRepository.fetchBalances();
      List<Balance> p2pBalances = await _walletRepository.fetchP2PBalances();
      List<Balance> savingBalances = await _walletRepository.fetchSavingBalances();

      List<Currency> currencies = await _walletRepository.fetchCurrencies();
      // adding balances into the required lists
      balancesList.assignAll(spotBalances);
      p2pList.assignAll(p2pBalances);
      savingList.assignAll(savingBalances);

      currenciesList.assignAll(currencies);
      //combining the balances and the currencies together
      List<Wallet> spotWallets = await formateWallets(spotBalances, currencies);
      List<Wallet> p2pWallets = await formateWallets(p2pBalances, currencies);
      List<Wallet> savingWallets = await formateWallets(savingBalances, currencies);
      //adding them to the variables
      walletsList.assignAll(spotWallets);
      p2pWalletsList.assignAll(p2pWallets);
      savingWalletsList.assignAll(savingWallets);
      searchWalletsList.assignAll(spotWallets);
      fetchP2pTotalEstimate();
      fetchSavingTotalEstimate();
      fetchSpotTotalEstimate();
      addAll();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      errorController.handleError(error);
    }
  }

  Future<List<Wallet>> formateWallets(
      List<Balance> balances, List<Currency> currencies) async {
    var wallets = <Wallet>[];

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

  void fetchP2pTotalEstimate(){
    double estimatedValueUSD = EstimatedValue.estimateValue(
      'USD',
      currenciesList,
      p2pWalletsList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    String estimatedValueSecondary = EstimatedValue.estimateUnitValue(
      'BTC',
      'USD',
      estimatedValueUSD,
      currenciesList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    estimatedValueUsdP2p.value = estimatedValueUSD;
    estimatedValueP2p.value = estimatedValueSecondary;
  }

  void fetchSavingTotalEstimate(){
    double estimatedValueUSD = EstimatedValue.estimateValue(
      'USD',
      currenciesList,
      savingWalletsList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    String estimatedValueSecondary = EstimatedValue.estimateUnitValue(
      'BTC',
      'USD',
      estimatedValueUSD,
      currenciesList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    estimatedValueUsdSaving.value = estimatedValueUSD;
    estimatedValueSaving.value = estimatedValueSecondary;
  }

  void fetchSpotTotalEstimate(){
    double estimatedValueUSD = EstimatedValue.estimateValue(
      'USD',
      currenciesList,
      walletsList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    String estimatedValueSecondary = EstimatedValue.estimateUnitValue(
      'BTC',
      'USD',
      estimatedValueUSD,
      currenciesList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    estimatedValueUsdSpot.value = estimatedValueUSD;
    estimatedValueSpot.value = estimatedValueSecondary;
  }

  void addAll(){
    estimatedValueUSDAll.value = estimatedValueUsdSpot.value + estimatedValueUsdP2p.value + estimatedValueUsdSaving.value;
    estimatedValueAll.value = (double.parse(estimatedValueSpot.value) + double.parse(estimatedValueP2p.value) + double.parse(estimatedValueSaving.value)).toString();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
