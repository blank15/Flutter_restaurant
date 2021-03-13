import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInit extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantSuccess<T> extends RestaurantState {
  final T data;

  RestaurantSuccess({@required this.data});

  @override
  List<Object> get props => super.props;
}

class RestaurantDetail<T> extends RestaurantState {
  final T data;

  RestaurantDetail({@required this.data});

  @override
  List<Object> get props => super.props;
}


class RestaurantNoInternet extends RestaurantState {}

class RestaurantFailed<String> extends RestaurantState {
  final String error;

  RestaurantFailed({@required this.error});

  @override
  List<Object> get props => super.props;
}

class SuccessSaveFavorite<T> extends RestaurantState{
  final T data;

  SuccessSaveFavorite({@required this.data});

  @override
  List<Object> get props => super.props;

}
class SuccessDeleteFavorite<T> extends RestaurantState{
  final T data;

  SuccessDeleteFavorite({@required this.data});
  @override
  List<Object> get props => super.props;
}
class FailedFavorite<String> extends RestaurantState{
  final String error;

  FailedFavorite({@required this.error});

  @override
  // TODO: implement props
  List<Object> get props => super.props;
}
