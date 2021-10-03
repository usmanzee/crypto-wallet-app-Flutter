import 'package:json_annotation/json_annotation.dart';

part 'payment_method_detail.g.dart';

@JsonSerializable()
class PaymentMethodDetail {
  PaymentMethodDetail({
    this.fieldName,
    this.type,
    this.multiLine,
    this.lengthLimit,
    this.isRequired,
    this.hintText,
  });

  @JsonKey(name: 'fieldName')
  String fieldName;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'multiLine')
  bool multiLine;
  @JsonKey(name: 'lengthLimit')
  int lengthLimit;
  @JsonKey(name: 'isRequired')
  bool isRequired;
  @JsonKey(name: 'hintText')
  String hintText;

  factory PaymentMethodDetail.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDetailToJson(this);
}
