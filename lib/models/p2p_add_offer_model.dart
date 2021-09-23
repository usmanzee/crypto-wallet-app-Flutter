import 'package:flutter/material.dart';
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

  // @JsonKey(name: 'payment_methods')
  // String paymentMethods;
  @JsonKey(name: 'time_limit')
  int timeLimit;
  @JsonKey(name: 'note')
  String note;
  @JsonKey(name: 'margin')
  double margin;
  @JsonKey(name: 'auto_reply')
  String autoReply;

  P2pAddOfferModel({
    @required this.originAmount,
    @required this.price,
    @required this.baseUnit,
    @required this.quoteUnit,
    @required this.minOrderAmount,
    @required this.maxOrderAmount,
    @required this.side,
    // this.paymentMethods,
    @required this.timeLimit,
    @required this.note,
    @required this.autoReply,
    @required this.margin,
  });

  factory P2pAddOfferModel.fromJson(Map<String, dynamic> json) =>
      _$P2pAddOfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$P2pAddOfferModelToJson(this);
}
