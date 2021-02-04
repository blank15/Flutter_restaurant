
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FoodEntity extends Equatable {
  final String name;

  FoodEntity({@required this.name});

  @override
  List<Object> get props => [name];

  factory FoodEntity.fromJson(Map<String, dynamic> json) {
    return FoodEntity(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> ToJson(FoodEntity instance) =>
      <String, dynamic>{
        'name': instance.name,
      };


}