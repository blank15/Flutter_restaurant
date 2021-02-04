import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/remote/model/restaurants_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  @JsonKey(name: "error")
  final bool error;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "count")
  final int count;
  @JsonKey(name: "restaurants")
  final List<RestaurantsModel> restaurants;

  BaseModel(
      {@required this.error,
      @required this.message,
      @required this.count,
      @required this.restaurants});

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
