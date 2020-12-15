import 'dart:async';
import 'package:crypto_template/models/DepositAddress.dart';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/balance.dart';
import 'package:crypto_template/models/currency.dart';

class WalletRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<List<Balance>> fetchBalances() async {
    final response = await apiProvider.get('peatio/account/balances');
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
