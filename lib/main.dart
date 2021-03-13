import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant/bloc/detail_restaurant/detail_bloc.dart';
import 'package:flutter_restaurant/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_restaurant/bloc/notification/notification_bloc.dart';
import 'package:flutter_restaurant/bloc/search_restaurant/search_restaurant.dart';
import 'package:flutter_restaurant/data/local/db/database_module.dart';
import 'package:flutter_restaurant/data/local/local_source_database.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository_impl.dart';
import 'package:flutter_restaurant/helper/navigation.dart';
import 'package:flutter_restaurant/ui/detail_restaurant_screen.dart';
import 'package:flutter_restaurant/ui/favorite_screen.dart';
import 'package:flutter_restaurant/ui/home_screen.dart';
import 'package:flutter_restaurant/ui/search_screen.dart';
import 'package:flutter_restaurant/ui/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/bloc.dart';
import 'common/style.dart';
import 'data/local/local_preference.dart';
import 'data/remote/api/api_service.dart';
import 'data/remote/api/dio_client.dart';
import 'helper/background_service.dart';
import 'helper/notification_helper.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  RestaurantRepository _repository = RestaurantRepositoryImpl(localSourceDatabase: LocalSourceDatabaseImpl(database:  AppDatabase()),
      apiService: ApiServiceImpl(
  dio: DioClient(apiBaseUrl: "https://restaurant-api.dicoding.dev/").dio));
  LocalPreferences _preferences;
  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    asyncTask();
    _preferences = LocalPreferences(preferences:sharedPreferences );
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
        BlocProvider(
            create: (context) => FavoriteBloc(
                repository: _repository)),
        BlocProvider(
            create: (context) => NotificationBloc(
                repository: _repository,preferences:_preferences )),
      ],
      child: MaterialApp(
        title: 'Restaurant app',
        navigatorKey: navigatorKey,
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

  void asyncTask() async{
    sharedPreferences =  await SharedPreferences.getInstance();
  }
}
