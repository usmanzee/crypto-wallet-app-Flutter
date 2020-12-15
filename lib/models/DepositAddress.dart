import 'dart:convert';

DepositAddress depositAddressFromJson(String str) =>
    DepositAddress.fromJson(json.decode(str));

String depositAddressToJson(DepositAddress data) => json.encode(data.toJson());

class DepositAddress {
  DepositAddress({
    this.currency,
    this.address,
  });

  String currency;
  String address;

  factory DepositAddress.fromJson(Map<String, dynamic> json) => DepositAddress(
        currency: json["currency"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "address": address,
      };
}
