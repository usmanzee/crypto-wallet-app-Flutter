import 'dart:convert';

MemberLevel memberLevelFromJson(String str) =>
    MemberLevel.fromJson(json.decode(str));

String memberLevelToJson(MemberLevel data) => json.encode(data.toJson());

class MemberLevel {
  MemberLevel({
    this.deposit,
    this.withdraw,
    this.trading,
  });

  LevelType deposit;
  LevelType withdraw;
  LevelType trading;

  factory MemberLevel.fromJson(Map<String, dynamic> json) => MemberLevel(
        deposit: LevelType.fromJson(json["deposit"]),
        withdraw: LevelType.fromJson(json["withdraw"]),
        trading: LevelType.fromJson(json["trading"]),
      );

  Map<String, dynamic> toJson() => {
        "deposit": deposit.toJson(),
        "withdraw": withdraw.toJson(),
        "trading": trading.toJson(),
      };
}

class LevelType {
  LevelType({
    this.minimumLevel,
  });

  int minimumLevel;

  factory LevelType.fromJson(Map<String, dynamic> json) => LevelType(
        minimumLevel: json["minimum_level"],
      );

  Map<String, dynamic> toJson() => {
        "minimum_level": minimumLevel,
      };
}
