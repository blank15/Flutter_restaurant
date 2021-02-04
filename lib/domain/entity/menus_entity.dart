import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant/domain/entity/drinks_entity.dart';
import 'package:flutter_restaurant/domain/entity/food_entity.dart';

class MenuEntity extends Equatable {
  final List<FoodEntity> foods;

  final List<DrinkEntity> drinks;

  MenuEntity({@required this.foods, @required this.drinks});

  @override
  List<Object> get props => [foods, drinks];

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      foods: (json['foods'] as List)
          ?.map((e) =>
      e == null ? null : FoodEntity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      drinks: (json['drinks'] as List)
          ?.map((e) =>
      e == null ? null : DrinkEntity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }
  Map<String, dynamic> toMap() =>
      <String, dynamic>{
        'foods': foods,
        'drinks':drinks,
      };

}
