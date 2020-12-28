import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/api/api_service.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RestaurantBloc(
                    apiService: ApiService(
                        dio: Dio(BaseOptions(
                  baseUrl: "https://restaurant-api.dicoding.dev",
                  connectTimeout: 50000,
                  receiveTimeout: 30000,
                ))))),
        BlocProvider(
            create: (context) => DetailBloc(
                    apiService: ApiService(
                        dio: Dio(BaseOptions(
                  baseUrl: "https://restaurant-api.dicoding.dev",
                  connectTimeout: 50000,
                  receiveTimeout: 30000,
                ))))),
        BlocProvider(
            create: (context) => SearchBloc(
                    apiService: ApiService(
                        dio: Dio(BaseOptions(
                  baseUrl: "https://restaurant-api.dicoding.dev",
                  connectTimeout: 50000,
                  receiveTimeout: 30000,
                ))))),
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
