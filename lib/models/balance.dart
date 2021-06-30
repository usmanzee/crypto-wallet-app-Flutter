import 'dart:convert';

List<Balance> balanceFromJson(String str) =>
    List<Balance>.from(json.decode(str).map((x) => Balance.fromJson(x)));

String balanceToJson(List<Balance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Balance {
  Balance({
    this.currency,
    this.balance,
    this.locked,
    this.id,
  });

  String currency;
  String balance;
  String locked;
  int id;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        currency: json["currency"],
        balance: json["balance"],
        locked: json["locked"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() =>
      {"currency": currency, "balance": balance, "locked": locked, "id": id};
}
