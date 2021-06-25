import 'package:json_annotation/json_annotation.dart';

part 'plans_model.g.dart';

@JsonSerializable()
class Plans {
  Plans({
    this.id,
    this.name,
    this.currencyId,
    this.type,
    this.rate,
    this.compound,
    this.status,
    this.updatedAt,
  });
  @JsonKey(name: 'id')
  int id;
  String name;
  @JsonKey(name: 'currency_id')
  String currencyId;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'rate')
  String rate;
  @JsonKey(name: 'compound')
  String compound;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'update_at')
  DateTime updatedAt;

  factory Plans.fromJson(Map<String, dynamic> json) => _$PlansFromJson(json);
  Map<String, dynamic> toJson() => _$PlansToJson(this);

}
