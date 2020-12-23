import 'dart:async';
import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/models/DepositAddress.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/balance.dart';
import 'package:crypto_template/models/currency.dart';
import 'package:get/get.dart';

class WalletRepository {
  HomeController homeController = Get.find();

  ApiProvider apiProvider = new ApiProvider();
  Future<List<Balance>> fetchBalances() async {
    final response = await apiProvider.get('peatio/account/balances');
    print(response);
    return balanceFromJson(response);
  }

  Future<List<Currency>> fetchCurrencies() async {
    final response = await apiProvider.get('peatio/public/currencies');
    return currencyFromJson(response);
  }

  Future<DepositAddress> fetchDepositAddress(currency) async {
    final response =
        await apiProvider.get('peatio/account/deposit_address/$currency');
    return depositAddressFromJson(response);
  }
}
