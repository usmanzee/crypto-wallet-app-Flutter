import 'package:json_annotation/json_annotation.dart';

part 'created_offer_response.g.dart';

@JsonSerializable()
class CreatedOrderResponse {
  CreatedOrderResponse({
    this.id,
    this.amount,
    this.chatId,
    this.maker,
    this.taker,
    this.offer,
    this.createdAt,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'amount')
  String amount;
  @JsonKey(name: 'chat_id')
  int chatId;
  @JsonKey(name: 'maker')
  String maker;
  @JsonKey(name: 'taker')
  String taker;
  @JsonKey(name: 'offer')
  Offer offer;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  factory CreatedOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatedOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedOrderResponseToJson(this);
}

@JsonSerializable()
class Offer {
  Offer({
    this.id,
    this.memberId,
    this.price,
    this.availableAmount,
    this.originAmount,
    this.minOrderAmount,
    this.maxOrderAmount,
    this.state,
    this.baseUnit,
    this.quoteUnit,
    this.side,
    this.timeLimit,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.autoReply,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'member_id')
  int memberId;
  @JsonKey(name: 'price')
  String price;
  @JsonKey(name: 'available_amount')
  String availableAmount;
  @JsonKey(name: 'origin_amount')
  String originAmount;
  @JsonKey(name: 'min_order_amount')
  String minOrderAmount;
  @JsonKey(name: 'max_order_amount')
  String maxOrderAmount;
  @JsonKey(name: 'state')
  String state;
  @JsonKey(name: 'base_unit')
  String baseUnit;
  @JsonKey(name: 'quoted_at')
  String quoteUnit;
  @JsonKey(name: 'side')
  String side;
  @JsonKey(name: 'time_limit')
  String timeLimit;
  @JsonKey(name: 'note')
  String note;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'auto_reply')
  String autoReply;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
