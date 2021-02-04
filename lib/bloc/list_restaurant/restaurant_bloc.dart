import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository.dart';

import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  RestaurantBloc({@required this.repository}) : super(RestaurantInit());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchRestaurant) {
      try {
        yield RestaurantLoading();
        final response = await repository.fetchRestaurans();
        yield RestaurantSuccess(data: response);
      } on DioError catch (e) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.RECEIVE_TIMEOUT) {
          yield RestaurantNoInternet();
        } else if (e.type == DioErrorType.DEFAULT) {
          yield RestaurantNoInternet();
        } else {
          yield RestaurantFailed(error: e.message);
        }
      }
    }
  }
}
