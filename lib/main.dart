import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/api/api_service.dart';
import 'package:flutter_restaurant/api/dio_client.dart';
import 'package:flutter_restaurant/bloc/detail_restaurant/detail_bloc.dart';
import 'package:flutter_restaurant/bloc/search_restaurant/search_restaurant.dart';
import 'package:flutter_restaurant/ui/detail_restaurant.dart';
import 'package:flutter_restaurant/ui/home.dart';
import 'package:flutter_restaurant/ui/search.dart';

import 'bloc/bloc.dart';
import 'common/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  ApiService _apiService = ApiService(
      dio: DioClient(apiBaseUrl: "https://restaurant-api.dicoding.dev").dio);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RestaurantBloc(
                    apiService: _apiService)),
        BlocProvider(
            create: (context) => DetailBloc(
                   apiService: _apiService)),
        BlocProvider(
            create: (context) => SearchBloc(
                apiService: _apiService)),
      ],
      child: MaterialApp(
        title: 'Restaurant app',
        theme: ThemeData(
          primaryColor: colorPrimary,
          accentColor: colorSecondary,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Home.routeName,
        routes: {
          Home.routeName: (context) => Home(),
          DetailRestaurant.routeName: (context) => DetailRestaurant(
                restaurants: ModalRoute.of(context).settings.arguments,
              ),
          SearchView.routeName: (context) => SearchView()
        },
      ),
    );
  }
}
