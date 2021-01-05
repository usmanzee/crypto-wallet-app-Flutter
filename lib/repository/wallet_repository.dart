import 'dart:async';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/models/DepositAddress.dart';
import 'package:crypto_template/models/fiat_deposit_details.dart';
import 'package:crypto_template/models/withdraw_history.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/balance.dart';
import 'package:crypto_template/models/currency.dart';
import 'package:crypto_template/models/deposit_histroy.dart';
import 'package:get/get.dart';

class WalletRepository {
  HomeController homeController = Get.find();

  ApiProvider apiProvider;
  Future<List<Balance>> fetchBalances() async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.get('peatio/account/balances');
    return balanceFromJson(response);
  }

  Future<List<Currency>> fetchCurrencies() async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.get('peatio/public/currencies');
    return currencyFromJson(response);
  }

  Future<DepositAddress> fetchDepositAddress(currency) async {
    apiProvider = new ApiProvider();
    final response =
        await apiProvider.get('peatio/account/deposit_address/$currency');
    return depositAddressFromJson(response);
  }

  Future<List<DepositHistory>> fetchDepositHistory(currency) async {
    apiProvider = new ApiProvider();
    final response = await apiProvider
        .get('peatio/account/deposits/?page=1&currency=$currency&limit=6');
    return depositHistoryFromJson(response);
  }

  Future<List<WithdrawHistory>> fetchWithdrawHistory(currency) async {
    apiProvider = new ApiProvider();
    final response = await apiProvider
        .get('peatio/account/withdraws/?page=1&currency=$currency&limit=6');
    return withdrawHistoryFromJson(response);
  }

  Future<dynamic> withdrawCrypto(data) async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.post('peatio/account/withdraws', data);
    return response;
  }

  Future<List<FiatDepositDetails>> fetchFiatDepositDetail() async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.get('public_data/bank_details.json');
    return fiatDepositDetailsFromJson(response);
  }
}
