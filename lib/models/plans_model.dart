import 'package:json_annotation/json_annotation.dart';

part 'plans_model.g.dart';

@JsonSerializable()
class Plans {
  Plans({
    this.id,
    this.name,
    this.type,
    this.status,
    this.updatedAt,
  });

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  factory Plans.fromJson(Map<String, dynamic> json) => _$PlansFromJson(json);
  Map<String, dynamic> toJson() => _$PlansToJson(this);

}
