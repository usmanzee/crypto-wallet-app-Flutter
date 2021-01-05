import 'dart:convert';

List<Beneficiary> beneficiaryFromJson(String str) => List<Beneficiary>.from(
    json.decode(str).map((x) => Beneficiary.fromJson(x)));

String beneficiaryToJson(List<Beneficiary> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Beneficiary {
  Beneficiary({
    this.id,
    this.currency,
    this.name,
    this.description,
    this.data,
    this.state,
  });

  int id;
  String currency;
  String name;
  dynamic description;
  Data data;
  String state;

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json["id"],
        currency: json["currency"],
        name: json["name"],
        description: json["description"],
        data: Data.fromJson(json["data"]),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "name": name,
        "description": description,
        "data": data.toJson(),
        "state": state,
      };
}

class Data {
  Data({
    this.address,
  });

  String address;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
      };
}
