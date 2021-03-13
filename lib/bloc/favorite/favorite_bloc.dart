import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/repository/restaurant_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final RestaurantRepository repository;

  FavoriteBloc({@required this.repository}) : super(FavoriteInit());

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FetchListFavorite) {
      try {
        yield FavoriteLoading();
        final response = await repository.getAllFavorite();
        yield SuccessGetListFavorite(data: response);
      }  catch (e) {
        yield FailedGetFavorite(error: e.toString());
      }
    }
  }
}
