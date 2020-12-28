import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/model/restaurants_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'detail_model.g.dart';

@JsonSerializable()
class DetailModel {
  @JsonKey(name: "error")
  final bool error;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "count")
  final int count;
  @JsonKey(name: "restaurant")
  final RestaurantsModel restaurant;

  DetailModel(
      {@required this.error,
        @required this.message,
        @required this.count,
        @required this.restaurant});

  factory DetailModel.fromJson(Map<String, dynamic> json) =>
      _$DetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailModelToJson(this);
}