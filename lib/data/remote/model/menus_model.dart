import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'drinks_model.dart';
import 'foods_model.dart';
part 'menus_model.g.dart';

@JsonSerializable()
class MenusModel {
  @JsonKey(name: "foods")
  List<FoodsModel> foods;
  @JsonKey(name: "drinks")
  List<DrinksModel> drinks;

  MenusModel({@required this.foods,@required this.drinks});

  factory MenusModel.fromJson(Map<String, dynamic> json) =>
      _$MenusModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenusModelToJson(this);

}