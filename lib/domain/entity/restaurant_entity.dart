import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/domain/entity/menus_entity.dart';

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final bool isFavorite;
  final MenuEntity menus;
  final List<CategoryEntity> categoryEntity;

  RestaurantEntity(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.pictureId,
      @required this.city,
      @required this.rating,
      this.isFavorite,
      this.menus,
      this.categoryEntity});

  @override
  List<Object> get props =>
      [id, name, description, pictureId, city, rating, menus, categoryEntity];
}

class CategoryEntity extends Equatable {
  final String name;

  CategoryEntity({@required this.name});

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        name: json['name'],
      );

  static Map<String, String> toJson(CategoryEntity category) =>
      {'name': category.name};

  static String encode(List<CategoryEntity> data) => json.encode(
        data
            .map<Map<String, dynamic>>((data) => CategoryEntity.toJson(data))
            .toList(),
      );

  static List<CategoryEntity> decode(String data) => data == null
      ? <CategoryEntity>[]
      : (json.decode(data) as List<dynamic>)
          .map<CategoryEntity>((item) => CategoryEntity.fromJson(item))
          .toList();

  @override
  List<Object> get props => [name];
}
