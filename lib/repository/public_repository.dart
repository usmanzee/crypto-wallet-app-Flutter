import 'dart:async';
import 'package:b4u_wallet/models/MemberLevel.dart';
import 'package:b4u_wallet/network/api_provider.dart';

class PublicRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<MemberLevel> fetchMemberLevels() async {
    final response = await apiProvider.get('peatio/public/member-levels');
    return memberLevelFromJson(response);
  }
}
