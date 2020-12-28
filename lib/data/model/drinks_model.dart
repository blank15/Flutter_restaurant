
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drinks_model.g.dart';

@JsonSerializable()
class DrinksModel{
  @JsonKey(name: "name")
  String name;

  DrinksModel({@required this.name});

  factory DrinksModel.fromJson(Map<String, dynamic> json) =>
      _$DrinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrinksModelToJson(this);
}