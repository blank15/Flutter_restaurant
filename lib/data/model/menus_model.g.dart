// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenusModel _$MenusModelFromJson(Map<String, dynamic> json) {
  return MenusModel(
    foods: (json['foods'] as List)
        ?.map((e) =>
            e == null ? null : FoodsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    drinks: (json['drinks'] as List)
        ?.map((e) =>
            e == null ? null : DrinksModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenusModelToJson(MenusModel instance) =>
    <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };
