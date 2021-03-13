
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DrinkEntity extends Equatable {
  final String name;

  DrinkEntity({@required this.name});

  @override
  List<Object> get props => [name];

  factory DrinkEntity.fromJson(Map<String, dynamic> json) {
    return DrinkEntity(
      name: json['name'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}