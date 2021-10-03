import 'package:json_annotation/json_annotation.dart';

part 'p2p_offer_add_response.g.dart';

@JsonSerializable()
class P2POfferAddResponse {
  P2POfferAddResponse({
    this.id,
    this.originAmount,
    this.minOrderAmount,
    this.maxOrderAmount,
    this.availableAmount,
    this.price,
    this.baseUnit,
    this.quoteUnit,
    this.side,
    this.state,
    this.timeLimit,
    this.note,
    this.createdAt,
    this.updatedAt,
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
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory P2POfferAddResponse.fromJson(Map<String, dynamic> json) =>
      _$P2POfferAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$P2POfferAddResponseToJson(this);
}
