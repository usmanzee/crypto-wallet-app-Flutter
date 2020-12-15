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

class Wallet {
  String balance;
  String currency;
  String name;
  String type;
  String fee;
  String address;
  String locked;
  String explorerTransaction;
  String explorerAddress;
  dynamic fixed;
  String iconUrl;
  bool depositEnabled;
  bool withdrawEnabled;
  dynamic precision;
  dynamic swapFee;
  dynamic minSwapAmount;
  dynamic maxSwapAmount;

  Wallet({
    this.balance,
    this.currency,
    this.name,
    this.type,
    this.fee,
    this.address,
    this.locked,
    this.explorerTransaction,
    this.explorerAddress,
    this.fixed,
    this.iconUrl,
    this.depositEnabled,
    this.withdrawEnabled,
    this.precision,
    this.swapFee,
    this.minSwapAmount,
    this.maxSwapAmount,
  });
}
