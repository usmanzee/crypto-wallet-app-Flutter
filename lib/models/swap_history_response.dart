// To parse this JSON data, do
//
//     final swapHistoryResponse = swapHistoryResponseFromJson(jsonString);

import 'dart:convert';

List<SwapHistoryResponse> swapHistoryResponseFromJson(String str) =>
    List<SwapHistoryResponse>.from(
        json.decode(str).map((x) => SwapHistoryResponse.fromJson(x)));

String swapHistoryResponseToJson(List<SwapHistoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwapHistoryResponse {
  SwapHistoryResponse({
    this.inCurrencyId,
    this.outCurrencyId,
    this.inAmount,
    this.outAmountRequested,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic inCurrencyId;
  String outCurrencyId;
  String inAmount;
  String outAmountRequested;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory SwapHistoryResponse.fromJson(Map<String, dynamic> json) =>
      SwapHistoryResponse(
        inCurrencyId: json["in_currency_id"],
        outCurrencyId: json["out_currency_id"],
        inAmount: json["in_amount"],
        outAmountRequested: json["out_amount_requested"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "in_currency_id": inCurrencyId,
        "out_currency_id": outCurrencyId,
        "in_amount": inAmount,
        "out_amount_requested": outAmountRequested,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
