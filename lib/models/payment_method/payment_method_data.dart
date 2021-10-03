import 'package:b4u_wallet/models/payment_method/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_data.g.dart';

@JsonSerializable()
class PaymentMethodData {
  PaymentMethodData({
    this.userPaymentDetail,
    this.paymentMethod,
  });

  @JsonKey(name: 'user_payment_detail')
  String userPaymentDetail;
  @JsonKey(name: 'payment_method')
  PaymentMethod paymentMethod;

  factory PaymentMethodData.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDataToJson(this);
}

