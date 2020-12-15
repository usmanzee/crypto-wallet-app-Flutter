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
  });

  String currency;
  String balance;
  String locked;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        currency: json["currency"],
        balance: json["balance"],
        locked: json["locked"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "balance": balance,
        "locked": locked,
      };
}
