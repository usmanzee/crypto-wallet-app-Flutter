import 'dart:async';
import 'package:crypto_template/models/MemberLevel.dart';
import 'package:crypto_template/network/api_provider.dart';

class PublicRepository {
  ApiProvider apiProvider = new ApiProvider();

  Future<MemberLevel> fetchMemberLevels() async {
    final response = await apiProvider.get('peatio/public/member-levels');
    return memberLevelFromJson(response);
  }
}
