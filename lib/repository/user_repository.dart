import 'dart:async';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/user.dart';
import 'package:crypto_template/models/otp.dart';
import 'package:crypto_template/network/request_headers.dart';

class UserRepository {
  ApiProvider apiProvider;

  Future<dynamic> sendPasswordResetLink(dynamic data) async {
    apiProvider = new ApiProvider();
    final response = await apiProvider.post(
        'barong/identity/users/password/generate_code', data);
    return response;
  }

  Future<User> fetchUser() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('barong/resource/users/me');
    return userFromJson(response);
  }

  Future<Otp> fetchOTPCode() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.post('barong/resource/otp/generate_qrcode', {});
    return otpFromJson(response);
  }

  Future<dynamic> enableOTP(dynamic data) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('barong/resource/otp/enable', data);
    return response;
  }

  Future<dynamic> disableOTP(dynamic data) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.post('barong/resource/otp/disable', data);
    return response;
  }

  Future<dynamic> changePassword(dynamic data) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.put('barong/resource/users/password', data);
    return response;
  }
}
