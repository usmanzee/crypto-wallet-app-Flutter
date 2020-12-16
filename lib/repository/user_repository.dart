import 'dart:async';
import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/user.dart';

class UserRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<User> fetchUser() async {
    final response = await apiProvider.get('barong/resource/users/me');
    return userFromJson(response);
  }
}
