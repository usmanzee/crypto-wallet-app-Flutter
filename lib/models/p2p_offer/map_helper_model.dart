import 'package:json_annotation/json_annotation.dart';

part 'map_helper_model.g.dart';

@JsonSerializable()
class MapHelperModel{
  List<Variable> list;

  MapHelperModel(this.list);

  factory MapHelperModel.fromJson(Map<String, dynamic> json) =>
      _$MapHelperModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapHelperModelToJson(this);
}
@JsonSerializable()
class Variable{
  @JsonKey(name: 'name')
  String name;

  Variable(this.name);

  factory Variable.fromJson(Map<String, dynamic> json) =>
      _$VariableFromJson(json);

  Map<String, dynamic> toJson() => _$VariableToJson(this);
}