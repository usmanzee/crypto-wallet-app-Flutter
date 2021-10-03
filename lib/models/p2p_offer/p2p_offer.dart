import 'package:json_annotation/json_annotation.dart';

part 'p2p_offer.g.dart';

@JsonSerializable()
class P2POffer {
  P2POffer({
    this.id,
    this.price,
    this.availableAmount,
    this.originAmount,
    this.minOrderAmount,
    this.maxOrderAmount,
    this.baseUnit,
    this.quoteUnit,
    this.side,
    this.timeLimit,
    this.createdAt,
    this.updatedAt,
    // this.state,
    this.note,
    this.name,
    this.totalTrades,
    this.trades30Day,
    this.tradeCompletion30Day,
    this.rating,
    this.profileId,
    this.paymentMethodId,
    // this.member,
    this.autoReply,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'origin_amount')
  String originAmount;
  @JsonKey(name: 'min_order_amount')
  String minOrderAmount;
  @JsonKey(name: 'max_order_amount')
  String maxOrderAmount;
  @JsonKey(name: 'available_amount')
  String availableAmount;
  @JsonKey(name: 'price')
  String price;
  @JsonKey(name: 'base_unit')
  String baseUnit;
  @JsonKey(name: 'quote_unit')
  String quoteUnit;
  @JsonKey(name: 'side')
  String side;
  @JsonKey(name: 'state')
  String state;
  @JsonKey(name: 'time_limit')
  String timeLimit;
  @JsonKey(name: 'note')
  String note;
  @JsonKey(name: 'payment_method_id')
  int paymentMethodId;
  // @JsonKey(name: 'member')
  // Member member;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'auto_reply')
  String autoReply;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'total_trades')
  int totalTrades;
  @JsonKey(name: 'trades_30_day')
  int trades30Day;
  @JsonKey(name: 'tradecompletion_30day')
  int tradeCompletion30Day;
  @JsonKey(name: 'rating')
  String rating;
  @JsonKey(name: 'profile_id')
  int profileId;

  factory P2POffer.fromJson(Map<String, dynamic> json) =>
      _$P2POfferFromJson(json);

  Map<String, dynamic> toJson() => _$P2POfferToJson(this);
}
