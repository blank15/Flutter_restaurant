import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurants_model.g.dart';

@JsonSerializable()
class RestaurantsModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "pictureId")
  final String pictureId;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "rating")
  final double rating;

  RestaurantsModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.pictureId,
      @required this.city,
      @required this.rating});

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantsModelToJson(this);
}
