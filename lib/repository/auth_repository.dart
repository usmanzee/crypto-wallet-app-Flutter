import 'dart:async';
import 'package:b4u_wallet/network/api_provider.dart';
import 'package:b4u_wallet/models/user.dart';

class AuthRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<User> authenticate(dynamic authObject) async {
    final response =
        await apiProvider.post('barong/identity/sessions', authObject);
    print(response);
    return userFromJson(response);
  }

  Future<User> register(dynamic registerObject) async {
    final response =
        await apiProvider.post('barong/identity/users', registerObject);
    return userFromJson(response);
  }

  Future<dynamic> resendVerificationCode(dynamic object) async {
    final response = await apiProvider.post(
        'barong/identity/users/email/generate_code', object);
    return response;
  }
}
