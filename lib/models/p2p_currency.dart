import 'package:json_annotation/json_annotation.dart';

part 'p2p_currency.g.dart';

@JsonSerializable()
class P2PCurrency {
  P2PCurrency({
    this.id,
    this.name,
    this.symbol,
    this.type,
    this.depositEnabled,
    this.withdrawalEnabled,
    this.depositFee,
    this.minDepositAmount,
    this.withdrawFee,
    this.minWithdrawAmount,
    this.withdrawLimit24H,
    this.withdrawLimit72H,
    this.swapFee,
    this.minSwapAmount,
    this.maxSwapAmount,
    this.baseFactor,
    this.precision,
    this.position,
    this.explorerTransaction,
    this.explorerAddress,
    this.minConfirmations,
  });

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'symbol')
  String symbol;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'deposit_enabled')
  bool depositEnabled;
  @JsonKey(name: 'withdraw_enabled')
  bool withdrawalEnabled;
  @JsonKey(name: 'deposit_fee')
  String depositFee;
  @JsonKey(name: 'min_deposit_amount')
  String minDepositAmount;
  @JsonKey(name: 'withdraw_fee')
  String withdrawFee;
  @JsonKey(name: 'min_withdraw_fee')
  String minWithdrawAmount;
  @JsonKey(name: 'withdraw_limit_24h')
  String withdrawLimit24H;
  @JsonKey(name: 'withdraw_limit_72h')
  String withdrawLimit72H;
  @JsonKey(name: 'swap_fee')
  String swapFee;
  @JsonKey(name: 'min_swap_amount')
  String minSwapAmount;
  @JsonKey(name: 'max_swap_amount')
  String maxSwapAmount;
  @JsonKey(name: 'base_factor')
  double baseFactor;
  @JsonKey(name: 'precision')
  int precision;
  @JsonKey(name: 'position')
  int position;
  @JsonKey(name: 'explore_transaction')
  String explorerTransaction;
  @JsonKey(name: 'explorer_address')
  String explorerAddress;
  @JsonKey(name: 'min_confirmations')
  int minConfirmations;

  factory P2PCurrency.fromJson(Map<String, dynamic> json) =>
      _$P2PCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$P2PCurrencyToJson(this);
}
