import 'dart:convert';

List<TradeHistoryResponse> tradeHistoryResponseFromJson(String str) =>
    List<TradeHistoryResponse>.from(
        json.decode(str).map((x) => TradeHistoryResponse.fromJson(x)));

String tradeHistoryResponseToJson(List<TradeHistoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TradeHistoryResponse {
  TradeHistoryResponse({
    this.id,
    this.price,
    this.amount,
    this.total,
    this.feeCurrency,
    this.fee,
    this.feeAmount,
    this.market,
    this.createdAt,
    this.takerType,
    this.side,
    this.orderId,
  });

  int id;
  String price;
  String amount;
  String total;
  String feeCurrency;
  String fee;
  String feeAmount;
  String market;
  DateTime createdAt;
  String takerType;
  String side;
  int orderId;

  factory TradeHistoryResponse.fromJson(Map<String, dynamic> json) =>
      TradeHistoryResponse(
        id: json["id"],
        price: json["price"],
        amount: json["amount"],
        total: json["total"],
        feeCurrency: json["fee_currency"],
        fee: json["fee"],
        feeAmount: json["fee_amount"],
        market: json["market"],
        createdAt: DateTime.parse(json["created_at"]),
        takerType: json["taker_type"],
        side: json["side"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "amount": amount,
        "total": total,
        "fee_currency": feeCurrency,
        "fee": fee,
        "fee_amount": feeAmount,
        "market": market,
        "created_at": createdAt.toIso8601String(),
        "taker_type": takerType,
        "side": side,
        "order_id": orderId,
      };
}
