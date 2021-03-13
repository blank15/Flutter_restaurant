

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInit extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class SuccessGetListFavorite<T> extends FavoriteState {
  final T data;

  SuccessGetListFavorite({@required this.data});

  @override
  List<Object> get props => super.props;
}

class FailedGetFavorite<String> extends FavoriteState {
  final String error;

  FailedGetFavorite({@required this.error});

  @override
  List<Object> get props => super.props;
}