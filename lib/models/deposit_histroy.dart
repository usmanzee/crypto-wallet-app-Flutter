import 'dart:convert';

List<DepositHistory> depositHistoryFromJson(String str) =>
    List<DepositHistory>.from(
        json.decode(str).map((x) => DepositHistory.fromJson(x)));

String depositHistoryToJson(List<DepositHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepositHistory {
  DepositHistory({
    this.id,
    this.currency,
    this.amount,
    this.fee,
    this.txid,
    this.createdAt,
    this.confirmations,
    this.completedAt,
    this.state,
  });

  int id;
  String currency;
  String amount;
  String fee;
  String txid;
  DateTime createdAt;
  int confirmations;
  DateTime completedAt;
  String state;

  factory DepositHistory.fromJson(Map<String, dynamic> json) => DepositHistory(
        id: json["id"],
        currency: json["currency"],
        amount: json["amount"],
        fee: json["fee"],
        txid: json["txid"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        confirmations: json["confirmations"],
        completedAt: json["completed_at"] == null
            ? null
            : DateTime.parse(json["completed_at"]),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "amount": amount,
        "fee": fee,
        "txid": txid,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "confirmations": confirmations,
        "completed_at":
            completedAt == null ? null : completedAt.toIso8601String(),
        "state": state,
      };
}
