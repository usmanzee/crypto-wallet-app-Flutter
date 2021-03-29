import 'dart:async';
import 'package:b4u_wallet/models/verification_label.dart';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/models/user.dart';
import 'package:b4u_wallet/models/otp.dart';
import 'package:b4u_wallet/network/request_headers.dart';
import 'package:http/http.dart' as http;

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

  Future<List<VerificationLabel>> fetchLables() async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.get('barong/resource/labels');
    return verificationLabelFromJson(response);
  }

  Future<dynamic> sendPhoneVerificationCode(reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('barong/resource/phones', reqObj);
    return response;
  }

  Future<dynamic> reSendPhoneVerificationCode(reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.post('barong/resource/phones/send_code', reqObj);
    return response;
  }

  Future<dynamic> verifyPhonePinCode(reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    print(reqObj);
    final response =
        await apiProvider.post('barong/resource/phones/verify', reqObj);
    return response;
  }

  Future<dynamic> verifyIdentity(reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response = await apiProvider.post('barong/resource/profiles', reqObj);
    return response;
  }

  Future<dynamic> verifyDocuments(http.MultipartRequest request) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    var authHeaders = requestHeaders.setAuthHeaders();
    var headers = authHeaders;
    request.headers.addAll(headers);
    final response = await apiProvider.multiPart(request);
    return response;
  }

  Future<dynamic> saveFirebaseDeviceToken(dynamic reqObj) async {
    apiProvider = new ApiProvider();
    RequestHeaders requestHeaders = new RequestHeaders();
    apiProvider.headers = requestHeaders.setAuthHeaders();
    final response =
        await apiProvider.post('peatio/account/notifications-token', reqObj);
    return response;
  }
}
