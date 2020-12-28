import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent {}

class FetchDetailRestaurant extends RestaurantEvent{
  final String id;
  FetchDetailRestaurant({@required this.id});
  @override
  List<Object> get props => [];
}