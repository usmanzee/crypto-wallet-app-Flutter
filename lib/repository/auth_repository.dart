import 'package:crypto_template/network/api_provider.dart';
import 'package:crypto_template/models/user.dart';

class AuthRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<User> authenticate(dynamic authObject) async {
    final response =
        await apiProvider.post('barong/identity/sessions', authObject);
    return userFromJson(response);
  }

  Future<User> register(dynamic registerObject) async {
    final response =
        await apiProvider.post('barong/identity/users', registerObject);
    return userFromJson(response);
  }
}
