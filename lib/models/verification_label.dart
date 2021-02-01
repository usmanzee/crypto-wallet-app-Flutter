import 'dart:convert';

List<VerificationLabel> verificationLabelFromJson(String str) =>
    List<VerificationLabel>.from(
        json.decode(str).map((x) => VerificationLabel.fromJson(x)));

String verificationLabelToJson(List<VerificationLabel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerificationLabel {
  VerificationLabel({
    this.key,
    this.value,
    this.scope,
    this.createdAt,
    this.updatedAt,
  });

  String key;
  String value;
  String scope;
  DateTime createdAt;
  DateTime updatedAt;

  factory VerificationLabel.fromJson(Map<String, dynamic> json) =>
      VerificationLabel(
        key: json["key"],
        value: json["value"],
        scope: json["scope"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "scope": scope,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
