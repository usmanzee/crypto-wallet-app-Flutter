import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_p2p_offer_model.g.dart';

@JsonSerializable()
class AddP2pOfferModel {
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
  @JsonKey(name: 'payment_methods')
  String paymentMethods;
  @JsonKey(name: 'time_limit')
  int timeLimit;
  @JsonKey(name: 'note')
  String note;
  @JsonKey(name: 'margin')
  double margin;
  @JsonKey(name: 'auto_reply')
  String autoReply;

  AddP2pOfferModel({
    @required this.originAmount,
    @required this.price,
    @required this.baseUnit,
    @required this.quoteUnit,
    @required this.minOrderAmount,
    @required this.maxOrderAmount,
    @required this.side,
    @required this.paymentMethods,
    @required this.timeLimit,
    @required this.note,
    @required this.margin,
    @required this.autoReply,
  });

  factory AddP2pOfferModel.fromJson(Map<String, dynamic> json) =>
      _$AddP2pOfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddP2pOfferModelToJson(this);
}
