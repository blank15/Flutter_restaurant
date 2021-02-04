import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository.dart';

class SearchBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  SearchBloc({@required this.repository}) : super(RestaurantInit());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is SearchRestaurant) {
      yield RestaurantLoading();
      try {
        final response = await repository.searchRestaurant(event.query);
        if (response.isNotEmpty) {
          yield RestaurantSuccess(data: response);
        } else {
          yield RestaurantFailed(error: "Data Pencarian kosong");
        }
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
