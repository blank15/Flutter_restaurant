import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categorie_model.g.dart';

@JsonSerializable()
class CategorieModel {
  @JsonKey(name: "name")
  String name;

  CategorieModel({@required this.name});

  factory CategorieModel.fromJson(Map<String, dynamic> json) =>
      _$CategorieModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategorieModelToJson(this);
}
