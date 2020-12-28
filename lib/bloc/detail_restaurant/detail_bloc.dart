import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/api/api_service.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';

class DetailBloc extends Bloc<RestaurantEvent,RestaurantState>{
  final ApiService apiService;

  DetailBloc({@required this.apiService}) : super(RestaurantInit());
  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event)async*  {
   if(event is FetchDetailRestaurant){
     yield RestaurantLoading();
     try {
       final response = await apiService.fetchDetail(event.id);
       debugPrint('data bloc ${response.restaurant.categorieModel}');
       yield RestaurantSuccess(data: response.restaurant);
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
}