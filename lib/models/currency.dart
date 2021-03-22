import 'dart:convert';

List<Currency> currencyFromJson(String str) =>
    List<Currency>.from(json.decode(str).map((x) => Currency.fromJson(x)));

String currencyToJson(List<Currency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currency {
  Currency({
    this.id,
    this.name,
    this.symbol,
    this.explorerTransaction,
    this.explorerAddress,
    this.type,
    this.depositEnabled,
    this.withdrawalEnabled,
    this.depositFee,
    this.minDepositAmount,
    this.withdrawFee,
    this.minWithdrawAmount,
    this.withdrawLimit24H,
    this.withdrawLimit72H,
    this.baseFactor,
    this.precision,
    this.position,
    this.iconUrl,
    this.minConfirmations,
    this.swapFee,
    this.minSwapAmount,
    this.maxSwapAmount,
  });

  String id;
  String name;
  String symbol;
  String explorerTransaction;
  String explorerAddress;
  String type;
  bool depositEnabled;
  bool withdrawalEnabled;
  String depositFee;
  String minDepositAmount;
  String withdrawFee;
  String minWithdrawAmount;
  String withdrawLimit24H;
  String withdrawLimit72H;
  int baseFactor;
  int precision;
  int position;
  String iconUrl;
  int minConfirmations;
  String swapFee;
  String minSwapAmount;
  String maxSwapAmount;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        explorerTransaction: json["explorer_transaction"] == null
            ? null
            : json["explorer_transaction"],
        explorerAddress:
            json["explorer_address"] == null ? null : json["explorer_address"],
        // type: typeValues.map[json["type"]],
        type: json["type"],
        depositEnabled: json["deposit_enabled"],
        withdrawalEnabled: json["withdrawal_enabled"],
        depositFee: json["deposit_fee"],
        minDepositAmount: json["min_deposit_amount"],
        withdrawFee: json["withdraw_fee"],
        minWithdrawAmount: json["min_withdraw_amount"],
        withdrawLimit24H: json["withdraw_limit_24h"],
        withdrawLimit72H: json["withdraw_limit_72h"],
        // baseFactor: json["base_factor"].toDouble(),
        baseFactor: json["base_factor"],
        precision: json["precision"],
        position: json["position"],
        iconUrl: json["icon_url"],
        minConfirmations: json["min_confirmations"] == null
            ? null
            : json["min_confirmations"],
        // swapFee: json["swap_fee"].toDouble(),
        // minSwapAmount: json["min_swap_amount"].toDouble(),
        swapFee: json["swap_fee"],
        minSwapAmount: json["min_swap_amount"],
        maxSwapAmount: json["max_swap_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "explorer_transaction":
            explorerTransaction == null ? null : explorerTransaction,
        "explorer_address": explorerAddress == null ? null : explorerAddress,
        "type": typeValues.reverse[type],
        "deposit_enabled": depositEnabled,
        "withdrawal_enabled": withdrawalEnabled,
        "deposit_fee": depositFee,
        "min_deposit_amount": minDepositAmount,
        "withdraw_fee": withdrawFee,
        "min_withdraw_amount": minWithdrawAmount,
        "withdraw_limit_24h": withdrawLimit24H,
        "withdraw_limit_72h": withdrawLimit72H,
        "base_factor": baseFactor,
        "precision": precision,
        "position": position,
        "icon_url": iconUrl,
        "min_confirmations": minConfirmations == null ? null : minConfirmations,
        "swap_fee": swapFee,
        "min_swap_amount": minSwapAmount,
        "max_swap_amount": maxSwapAmount,
      };
}

enum Type { COIN, FIAT }

final typeValues = EnumValues({"coin": Type.COIN, "fiat": Type.FIAT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
