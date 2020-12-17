import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/detail_restaurant.dart';
import 'package:flutter_restaurant/ui/home.dart';

import 'common/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            )
      },
    );
  }
}
