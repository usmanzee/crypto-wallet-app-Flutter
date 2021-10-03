import 'package:json_annotation/json_annotation.dart';

part 'name_helper_model.g.dart';

@JsonSerializable()
class NameHelperModel {
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'Payment Details')
  String paymentDetails;
  @JsonKey(name:'Card serial')
  String cardSerial;

  NameHelperModel(this.name, this.paymentDetails, this.cardSerial);

  factory NameHelperModel.fromJson(Map<String, dynamic> json) =>
      _$NameHelperModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameHelperModelToJson(this);
}
