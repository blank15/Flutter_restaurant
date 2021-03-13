
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }


}