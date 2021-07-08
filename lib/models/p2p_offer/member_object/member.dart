import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  Member({
    this.id,
    this.uid,
    this.email,
    this.level,
    this.role,
    this.group,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.notificationToken,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'u_id')
  String uid;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'level')
  int level;
  @JsonKey(name: 'role')
  String role;
  @JsonKey(name: 'group')
  String group;
  @JsonKey(name: 'state')
  String state;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'notification_token')
  String notificationToken;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
