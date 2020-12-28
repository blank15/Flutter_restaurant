// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailModel _$DetailModelFromJson(Map<String, dynamic> json) {
  return DetailModel(
    error: json['error'] as bool,
    message: json['message'] as String,
    count: json['count'] as int,
    restaurant: json['restaurant'] == null
        ? null
        : RestaurantsModel.fromJson(json['restaurant'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DetailModelToJson(DetailModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'count': instance.count,
      'restaurant': instance.restaurant,
    };
