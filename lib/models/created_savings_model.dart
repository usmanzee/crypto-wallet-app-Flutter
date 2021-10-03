import 'package:json_annotation/json_annotation.dart';

part 'created_savings_model.g.dart';

@JsonSerializable()
class CreatedSavingsModel {
  CreatedSavingsModel({
    this.id,
    this.amount,
    this.planId,
    this.aasmState,
    this.accountId,
    this.autoSubscribe,
    this.updatedAt,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'amount')
  String amount;
  @JsonKey(name: 'plan_id')
  String planId;
  @JsonKey(name: 'aasm_state')
  String aasmState;
  @JsonKey(name: 'account_id')
  int accountId;
  @JsonKey(name: 'auto_subscribe')
  bool autoSubscribe;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory CreatedSavingsModel.fromJson(Map<String, dynamic> json) =>
      _$CreatedSavingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedSavingsModelToJson(this);
}
