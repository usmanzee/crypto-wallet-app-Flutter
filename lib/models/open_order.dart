import 'dart:convert';

List<OpenOrder> openOrderFromJson(String str) =>
    List<OpenOrder>.from(json.decode(str).map((x) => OpenOrder.fromJson(x)));

String openOrderToJson(List<OpenOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpenOrder {
  OpenOrder({
    this.id,
    this.side,
    this.ordType,
    this.price,
    this.avgPrice,
    this.state,
    this.market,
    this.createdAt,
    this.originVolume,
    this.remainingVolume,
    this.executedVolume,
    this.tradesCount,
  });

  int id;
  String side;
  String ordType;
  String price;
  String avgPrice;
  String state;
  String market;
  DateTime createdAt;
  String originVolume;
  String remainingVolume;
  String executedVolume;
  int tradesCount;

  factory OpenOrder.fromJson(Map<String, dynamic> json) => OpenOrder(
        id: json["id"],
        side: json["side"],
        ordType: json["ord_type"],
        price: json["price"],
        avgPrice: json["avg_price"],
        state: json["state"],
        market: json["market"],
        createdAt: DateTime.parse(json["created_at"]),
        originVolume: json["origin_volume"],
        remainingVolume: json["remaining_volume"],
        executedVolume: json["executed_volume"],
        tradesCount: json["trades_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "side": side,
        "ord_type": ordType,
        "price": price,
        "avg_price": avgPrice,
        "state": state,
        "market": market,
        "created_at": createdAt.toIso8601String(),
        "origin_volume": originVolume,
        "remaining_volume": remainingVolume,
        "executed_volume": executedVolume,
        "trades_count": tradesCount,
      };
}
