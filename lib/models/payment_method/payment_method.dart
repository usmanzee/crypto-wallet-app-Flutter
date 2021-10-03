import 'package:json_annotation/json_annotation.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod {
  PaymentMethod({
    this.name,
    this.slug,
  });

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'slug')
  String slug;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
