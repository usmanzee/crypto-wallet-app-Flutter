import 'dart:convert';

TradingFee tradingFeeFromJson(String str) =>
    TradingFee.fromJson(json.decode(str));

String tradingFeeToJson(TradingFee data) => json.encode(data.toJson());

class TradingFee {
  TradingFee({
    this.id,
    this.group,
    this.marketId,
    this.maker,
    this.taker,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String group;
  String marketId;
  String maker;
  String taker;
  DateTime createdAt;
  DateTime updatedAt;

  factory TradingFee.fromJson(Map<String, dynamic> json) => TradingFee(
        id: json["id"],
        group: json["group"],
        marketId: json["market_id"],
        maker: json["maker"],
        taker: json["taker"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group": group,
        "market_id": marketId,
        "maker": maker,
        "taker": taker,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
