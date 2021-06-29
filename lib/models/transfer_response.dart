import 'package:json_annotation/json_annotation.dart';

part 'transfer_response.g.dart';

@JsonSerializable()
class TransferResponse {
  TransferResponse({
    this.id,
    this.currency,
    this.accountType,
    this.balance,
    this.locked,
  });
  @JsonKey(name: 'id',)
  int id;
  @JsonKey(name: 'currency')
  String currency;
  @JsonKey(name: 'account_type')
  String accountType;
  @JsonKey(name: 'balance')
  String balance;
  @JsonKey(name: 'locked')
  String locked;


  factory TransferResponse.fromJson(Map<String, dynamic> json) => _$TransferResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TransferResponseToJson(this);
}
