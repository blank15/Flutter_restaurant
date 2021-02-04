import 'package:flutter_restaurant/data/local/db/database_module.dart';
import 'package:flutter_restaurant/data/local/db/table/favorite_restaurant.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'restaurant_dao.g.dart';

@UseDao(tables: [FavoriteRestaurant])
class RestaurantDao extends DatabaseAccessor<AppDatabase>
    with _$RestaurantDaoMixin {
  RestaurantDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<int> insertFavorite(FavoriteRestaurantData data) {
    return into(favoriteRestaurant).insert(data);
  }

  Future<List<FavoriteRestaurantData>> getAllFavorite() =>
      (select(favoriteRestaurant)).get();

  Future<FavoriteRestaurantData> getDetailFavorite(String id) =>
      (select(favoriteRestaurant)..where((tbl) => tbl.id.equals(id)))
          .getSingle();

  Future deleteFavorite(String id) =>
      (delete(favoriteRestaurant)..where((tbl) => tbl.id.equals(id))).go();
}
