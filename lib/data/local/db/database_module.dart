import 'package:flutter_restaurant/data/local/db/restaurant_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'table/favorite_restaurant.dart';

part 'database_module.g.dart';

@UseMoor(tables: [
  FavoriteRestaurant
],
daos: [
  RestaurantDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'db_restaurant', logStatements: true));

  @override
  int get schemaVersion => 1;
}