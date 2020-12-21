import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/api/api_service.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final ApiService apiService;

  RestaurantBloc({@required this.apiService}) : super(RestaurantInit());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {

    yield RestaurantLoading();
    if(state is FetchRestaurant){
      try {
        final response = await apiService.fetchRestaurans();
        yield RestaurantSuccess(data: response.restaurants);
      } on DioError catch(e){
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.RECEIVE_TIMEOUT) {
          yield RestaurantNoInternet();
        } else if (e.type == DioErrorType.DEFAULT) {
          yield RestaurantNoInternet();
        } else {
          yield RestaurantFailed(error: e.message);
        }
      }
    } else if(state is FetchDetailRestaurant){
      getDetail(event);
      
    }

  }

  Stream<RestaurantState> getDetail(RestaurantEvent event) async*{
    yield RestaurantLoading();
    try {
      final response = await apiService.fetchRestaurans();
      yield RestaurantSuccess(data: response.restaurants);
    } on DioError catch(e){
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
