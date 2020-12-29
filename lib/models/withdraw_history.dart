import 'dart:convert';

List<WithdrawHistory> withdrawHistoryFromJson(String str) =>
    List<WithdrawHistory>.from(
        json.decode(str).map((x) => WithdrawHistory.fromJson(x)));

String withdrawHistoryToJson(List<WithdrawHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WithdrawHistory {
  WithdrawHistory({
    this.id,
    this.currency,
    this.type,
    this.amount,
    this.fee,
    this.blockchainTxid,
    this.rid,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.doneAt,
  });

  int id;
  String currency;
  String type;
  String amount;
  String fee;
  String blockchainTxid;
  String rid;
  String state;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime completedAt;
  DateTime doneAt;

  factory WithdrawHistory.fromJson(Map<String, dynamic> json) =>
      WithdrawHistory(
        id: json["id"],
        currency: json["currency"],
        type: json["type"],
        amount: json["amount"],
        fee: json["fee"],
        blockchainTxid:
            json["blockchain_txid"] == null ? null : json["blockchain_txid"],
        rid: json["rid"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        completedAt: json["completed_at"] == null
            ? null
            : DateTime.parse(json["completed_at"]),
        doneAt:
            json["done_at"] == null ? null : DateTime.parse(json["done_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "type": type,
        "amount": amount,
        "fee": fee,
        "blockchain_txid": blockchainTxid == null ? null : blockchainTxid,
        "rid": rid,
        "state": state,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "completed_at":
            completedAt == null ? null : completedAt.toIso8601String(),
        "done_at": doneAt == null ? null : doneAt.toIso8601String(),
      };
}
