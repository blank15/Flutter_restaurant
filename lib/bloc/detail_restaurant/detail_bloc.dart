import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository.dart';
import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';

import '../bloc.dart';

class DetailBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository repository;

  DetailBloc({@required this.repository}) : super(RestaurantInit());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchDetailRestaurant) {
      yield* _getDetailRestaurant(event.id);
    } else if (event is SaveRestaurant) {
      yield* _saveRestaurant(event.data);
    } else if (event is DeleteFavorite) {
      yield* _deleteRestaurant(event.data);
    }
  }

  Stream<RestaurantState> _getDetailRestaurant(String id) async* {
    yield RestaurantLoading();
    try {
      final response = await repository.getDetailRestaurant(id);
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

  Stream<RestaurantState> _saveRestaurant(RestaurantEntity data) async* {
    try {
      debugPrint('data ${data.menus}');
      await repository.insertFavorite(data);
      yield SuccessSaveFavorite(data: data);
    } catch (e) {
      yield FailedFavorite(error: e.toString());
    }
  }

  Stream<RestaurantState> _deleteRestaurant(RestaurantEntity data) async* {
    try {
      await repository.deleteFavorite(data.id);
      yield SuccessDeleteFavorite(data: data);
    } catch (e) {
      yield FailedFavorite(error: e.toString());
    }
  }
}
