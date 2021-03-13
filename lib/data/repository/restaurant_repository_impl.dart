import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/local/db/database_module.dart';
import 'package:flutter_restaurant/data/local/local_source_database.dart';
import 'package:flutter_restaurant/data/remote/api/api_service.dart';
import 'package:flutter_restaurant/data/repository/restaurant_repository.dart';
import 'package:flutter_restaurant/domain/entity/drinks_entity.dart';
import 'package:flutter_restaurant/domain/entity/food_entity.dart';
import 'package:flutter_restaurant/domain/entity/menus_entity.dart';
import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final LocalSourceDatabase localSourceDatabase;
  final ApiService apiService;

  RestaurantRepositoryImpl(
      {@required this.localSourceDatabase, @required this.apiService});

  @override
  Future deleteFavorite(String id) async {
    return await localSourceDatabase.deleteFavorite(id);
  }

  @override
  Future<List<RestaurantEntity>> getAllFavorite() async {
    var response = await localSourceDatabase.getAllFavorite();
    var listRestaurant = <RestaurantEntity>[];
    response.forEach((data) {
      listRestaurant.add(RestaurantEntity(
          id: data.id,
          name: data.name,
          description: data.description,
          pictureId: data.pictureId,
          city: data.city,
          rating: double.parse(data.rating)));
    });
    return listRestaurant;
  }

  @override
  Future<RestaurantEntity> getDetailRestaurant(String id) async {
    var local = await localSourceDatabase.getDetailFavorite(id);
    debugPrint('data ${local.toString()}');
    if (local != null) {
      return RestaurantEntity(
          id: local.id,
          name: local.name,
          description: local.description,
          pictureId: local.pictureId,
          city: local.city,
          rating: double.parse(local.rating),
          isFavorite: true,
          menus: MenuEntity.fromJson(json.decode(local.jsonMenus)),
          categoryEntity: CategoryEntity.decode(local.jsonCategories));
    } else {
      var remote = await apiService.fetchDetail(id);
      var data = remote.restaurant;
      var foods = <FoodEntity>[];
      var drinks = <DrinkEntity>[];
      var categories = <CategoryEntity>[];
      data.menus.foods.forEach((data) {
        foods.add(FoodEntity(name: data.name));
      });
      data.menus.drinks.forEach((data) {
        drinks.add(DrinkEntity(name: data.name));
      });
      data.categorieModel.forEach((data) {
        categories.add(CategoryEntity(name: data.name));
      });
      MenuEntity menu = MenuEntity(foods: foods, drinks: drinks);
      return RestaurantEntity(
          id: data.id,
          name: data.name,
          description: data.description,
          pictureId: data.pictureId,
          city: data.city,
          rating: data.rating,
          isFavorite: false,
          menus: menu,
          categoryEntity: categories);
    }
  }

  @override
  Future<int> insertFavorite(RestaurantEntity data) async {
    var dataRestoran = FavoriteRestaurantData(
        id: data.id,
        name: data.name,
        description: data.description,
        pictureId: data.pictureId,
        city: data.city,
        rating: data.rating.toString(),
        jsonMenus:
            jsonEncode(MenuEntity(foods: data.menus.foods, drinks: data.menus.drinks).toJson()),
        jsonCategories: CategoryEntity.encode(data.categoryEntity));
    return await localSourceDatabase.insertFavorite(dataRestoran);
  }

  @override
  Future<List<RestaurantEntity>> searchRestaurant(String query) async {
    var response = await apiService.searchRestaurans(query);
    var dataSearch = <RestaurantEntity>[];
    response.restaurants.forEach((data) {
      dataSearch.add(RestaurantEntity(
          id: data.id,
          name: data.name,
          description: data.description,
          pictureId: data.pictureId,
          city: data.city,
          rating: data.rating));
    });
    return dataSearch;
  }

  @override
  Future<List<RestaurantEntity>> fetchRestaurans() async {
    var response = await apiService.fetchRestaurans();
    var dataFetch = <RestaurantEntity>[];
    response.restaurants.forEach((data) {
      dataFetch.add(RestaurantEntity(
          id: data.id,
          name: data.name,
          description: data.description,
          pictureId: data.pictureId,
          city: data.city,
          rating: data.rating));
    });
    return dataFetch;
  }
}
