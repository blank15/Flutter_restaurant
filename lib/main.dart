import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/detail_restaurant/detail_bloc.dart';
import 'package:flutter_restaurant/bloc/search_restaurant/search_restaurant.dart';
import 'package:flutter_restaurant/data/local/db/database_module.dart';
import 'package:flutter_restaurant/data/local/local_source_database.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository_impl.dart';
import 'package:flutter_restaurant/ui/detail_restaurant_screen.dart';
import 'package:flutter_restaurant/ui/favorite_screen.dart';
import 'package:flutter_restaurant/ui/home_screen.dart';
import 'package:flutter_restaurant/ui/search_screen.dart';
import 'package:flutter_restaurant/ui/setting_screen.dart';
import 'bloc/bloc.dart';
import 'common/style.dart';
import 'data/remote/api/api_service.dart';
import 'data/remote/api/dio_client.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  RestaurantRepository _repository = RestaurantRepositoryImpl(localSourceDatabase: LocalSourceDatabaseImpl(database:  AppDatabase()),
      apiService: ApiServiceImpl(
  dio: DioClient(apiBaseUrl: "https://restaurant-api.dicoding.dev/").dio));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RestaurantBloc(
                    repository: _repository)),
        BlocProvider(
            create: (context) => DetailBloc(
                repository: _repository)),
        BlocProvider(
            create: (context) => SearchBloc(
                repository: _repository)),
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
          SearchView.routeName: (context) => SearchView(),
          SettingScreen.routeName:(context) => SettingScreen(),
          FavoriteScreen.routeName:(context) =>FavoriteScreen()
        },
      ),
    );
  }
}
