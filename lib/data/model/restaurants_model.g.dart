// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurants_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantsModel _$RestaurantsModelFromJson(Map<String, dynamic> json) {
  return RestaurantsModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    pictureId: json['pictureId'] as String,
    city: json['city'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    menus: json['menus'] == null
        ? null
        : MenusModel.fromJson(json['menus'] as Map<String, dynamic>),
    categorieModel: (json['categories'] as List)
        ?.map((e) => e == null
            ? null
            : CategorieModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantsModelToJson(RestaurantsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pictureId': instance.pictureId,
      'city': instance.city,
      'rating': instance.rating,
      'menus': instance.menus,
      'categories': instance.categorieModel,
    };
