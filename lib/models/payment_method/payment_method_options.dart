import 'package:json_annotation/json_annotation.dart';

part 'payment_method_options.g.dart';

@JsonSerializable()
class PaymentMethodOptions {
  PaymentMethodOptions({
    this.options,
  });

  @JsonKey(name: 'options')
  String options;

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodOptionsToJson(this);
}
