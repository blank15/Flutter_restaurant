import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent {}

class FetchDetailRestaurant extends RestaurantEvent {
  final String id;

  FetchDetailRestaurant({@required this.id});

  @override
  List<Object> get props => [id];
}

class SearchRestaurant extends RestaurantEvent {
  final String query;

  SearchRestaurant({@required this.query});

  @override
  List<Object> get props => [query];
}

class SaveRestaurant extends RestaurantEvent {
  final RestaurantEntity data;

  SaveRestaurant({@required this.data});

  @override
  List<Object> get props => [data];
}

class DeleteFavorite extends RestaurantEvent {
  final RestaurantEntity data;

  DeleteFavorite({@required this.data});

  @override
  List<Object> get props => [data];
}
