import 'dart:async';
import 'package:b4u_wallet/controllers/HomeController.dart';
import 'package:b4u_wallet/models/Beneficiary.dart';
import 'package:b4u_wallet/models/DepositAddress.dart';
import 'package:b4u_wallet/models/fiat_deposit_details.dart';
import 'package:b4u_wallet/models/trade_histroy_response.dart';
import 'package:b4u_wallet/models/withdraw_history_response.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/models/balance.dart';
import 'package:b4u_wallet/models/currency.dart';
import 'package:b4u_wallet/models/deposit_histroy_response.dart';
import 'package:b4u_wallet/network/request_headers.dart';
import 'package:get/get.dart';

class WalletRepository {
  HomeController homeController = Get.find();

  ApiProvider apiProvider;

  Future<List<Balance>> fetchBalances() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/balances');
    return balanceFromJson(response);
  }

  Future<List<Balance>> fetchP2PBalances() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.get('peatio/account/balances?account_type=p2p');
    return balanceFromJson(response);
  }

  Future<List<Balance>> fetchSavingBalances() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.get('peatio/account/balances?account_type=saving');
    return balanceFromJson(response);
  }

  Future<List<Currency>> fetchCurrencies() async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.get('peatio/public/currencies');
    return currencyFromJson(response);
  }

  Future<DepositAddress> fetchDepositAddress(currency) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.get('peatio/account/deposit_address/$currency');
    return depositAddressFromJson(response);
  }

  Future<List<DepositHistoryResponse>> fetchDepositHistory(currency) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    var url = 'peatio/account/deposits';
    if (currency != '') {
      url += '/?page=1&currency=$currency&limit=6';
    }
    final response = await apiProvider.get(url);
    return depositHistoryFromJson(response);
  }

  Future<List<WithdrawHistoryResponse>> fetchWithdrawHistory(currency) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    var url = 'peatio/account/withdraws';
    if (currency != '') {
      url += '/?page=1&currency=$currency&limit=6';
    }
    final response = await apiProvider.get(url);
    return withdrawHistoryFromJson(response);
  }

  Future<List<TradeHistoryResponse>> fetchTradeHistory(currency) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    var url = 'peatio/market/trades';
    if (currency != '') {
      url += '/?page=1&currency=$currency&limit=6';
    }
    final response = await apiProvider.get(url);
    return tradeHistoryResponseFromJson(response);
  }

  Future<dynamic> withdrawCrypto(data) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('peatio/account/withdraws', data);
    return response;
  }

  Future<List<FiatDepositDetails>> fetchFiatDepositDetail() async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.get('public_data/bank_details.json');
    return fiatDepositDetailsFromJson(response);
  }

  Future<List<Beneficiary>> fetchBeneficiaries() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('peatio/account/beneficiaries');
    return beneficiaryFromJson(response);
  }
}
