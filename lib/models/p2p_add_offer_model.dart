import 'package:json_annotation/json_annotation.dart';

part 'p2p_add_offer_model.g.dart';

@JsonSerializable()
class P2pAddOfferModel {
  @JsonKey(name: 'origin_amount')
  double originAmount;
  @JsonKey(name: 'price')
  double price;
  @JsonKey(name: 'base_unit')
  String baseUnit;
  @JsonKey(name: 'quote_unit')
  String quoteUnit;
  @JsonKey(name: 'min_order_amount')
  double minOrderAmount;
  @JsonKey(name: 'max_order_amount')
  double maxOrderAmount;
  @JsonKey(name: 'side')
  String side;
  @JsonKey(name: 'payment_method')
  String paymentMethod;
  @JsonKey(name: 'time_limit')
  String timeLimit;
  @JsonKey(name: 'note')
  String note;
  @JsonKey(name: 'margin')
  String margin;
  @JsonKey(name: 'auto_reply')
  String autoReply;

  P2pAddOfferModel(
    this.originAmount,
    this.price,
    this.baseUnit,
    this.quoteUnit,
    this.minOrderAmount,
    this.maxOrderAmount,
    this.side,
    this.paymentMethod,
    this.timeLimit,
    this.note,
    this.autoReply,
    this.margin,
  );

  factory P2pAddOfferModel.fromJson(Map<String, dynamic> json) =>
      _$P2pAddOfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$P2pAddOfferModelToJson(this);
}
