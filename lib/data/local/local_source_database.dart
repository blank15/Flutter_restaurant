
import 'package:flutter/foundation.dart';

import 'db/database_module.dart';

abstract class LocalSourceDatabase{
  Future<int> insertFavorite(FavoriteRestaurantData data) ;

  Future<List<FavoriteRestaurantData>> getAllFavorite() ;

  Future<FavoriteRestaurantData> getDetailFavorite(String id) ;

  Future deleteFavorite(String id) ;
}

class LocalSourceDatabaseImpl extends LocalSourceDatabase {
  final AppDatabase database;

  LocalSourceDatabaseImpl({@required this.database});

  @override
  Future deleteFavorite(String id) async {
    return await database.restaurantDao.deleteFavorite(id);
  }

  @override
  Future<List<FavoriteRestaurantData>> getAllFavorite() async {
    return await database.restaurantDao.getAllFavorite();
  }

  @override
  Future<FavoriteRestaurantData> getDetailFavorite(String id) async {
    return await database.restaurantDao.getDetailFavorite(id);
  }

  @override
  Future<int> insertFavorite(FavoriteRestaurantData data)  async {
    return await database.restaurantDao.insertFavorite(data);
  }

}