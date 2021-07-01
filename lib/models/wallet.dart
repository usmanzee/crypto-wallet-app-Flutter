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
  String accountType;

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
    this.accountType
  });
}
