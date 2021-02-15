import 'dart:convert';

List<SwapHistoryResponse> swapHistoryResponseFromJson(String str) =>
    List<SwapHistoryResponse>.from(
        json.decode(str).map((x) => SwapHistoryResponse.fromJson(x)));

String swapHistoryResponseToJson(List<SwapHistoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwapHistoryResponse {
  SwapHistoryResponse({
    this.id,
    this.inCurrencyId,
    this.outCurrencyId,
    this.inAmount,
    this.outAmountRequested,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  String inCurrencyId;
  String outCurrencyId;
  String inAmount;
  double outAmountRequested;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory SwapHistoryResponse.fromJson(Map<String, dynamic> json) =>
      SwapHistoryResponse(
        id: json["id"],
        inCurrencyId: json["in_currency_id"],
        outCurrencyId: json["out_currency_id"],
        inAmount: json["in_amount"],
        outAmountRequested: json["out_amount_requested"].toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in_currency_id": inCurrencyId,
        "out_currency_id": outCurrencyId,
        "in_amount": inAmount,
        "out_amount_requested": outAmountRequested,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
