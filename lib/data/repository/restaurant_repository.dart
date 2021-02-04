import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<int> insertFavorite(RestaurantEntity data);

  Future<List<RestaurantEntity>> getAllFavorite();

  Future<RestaurantEntity> getDetailRestaurant(String id);

  Future deleteFavorite(String id);

  Future<List<RestaurantEntity>> searchRestaurant(String query);

  Future<List<RestaurantEntity>> fetchRestaurans();
}