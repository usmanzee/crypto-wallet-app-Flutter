import 'dart:convert';

List<Market> marketFromJson(String str) =>
    List<Market>.from(json.decode(str).map((x) => Market.fromJson(x)));

String marketToJson(List<Market> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Market {
  Market({
    this.id,
    this.name,
    this.baseUnit,
    this.quoteUnit,
    this.askFee,
    this.bidFee,
    this.minPrice,
    this.maxPrice,
    this.minAmount,
    this.amountPrecision,
    this.pricePrecision,
    this.state,
  });

  String id;
  String name;
  String baseUnit;
  String quoteUnit;
  String askFee;
  String bidFee;
  String minPrice;
  String maxPrice;
  String minAmount;
  int amountPrecision;
  int pricePrecision;
  String state;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"],
        name: json["name"],
        baseUnit: json["base_unit"],
        quoteUnit: json["quote_unit"],
        askFee: json["ask_fee"],
        bidFee: json["bid_fee"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        minAmount: json["min_amount"],
        amountPrecision: json["amount_precision"],
        pricePrecision: json["price_precision"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "base_unit": baseUnit,
        "quote_unit": quoteUnit,
        "ask_fee": askFee,
        "bid_fee": bidFee,
        "min_price": minPrice,
        "max_price": maxPrice,
        "min_amount": minAmount,
        "amount_precision": amountPrecision,
        "price_precision": pricePrecision,
        "state": state,
      };
}
