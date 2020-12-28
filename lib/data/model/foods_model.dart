import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'foods_model.g.dart';

@JsonSerializable()
class FoodsModel {
  @JsonKey(name: "name")
  String name;

  FoodsModel({@required this.name});

  factory FoodsModel.fromJson(Map<String, dynamic> json) =>
      _$FoodsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodsModelToJson(this);
}