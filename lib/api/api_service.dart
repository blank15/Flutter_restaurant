import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/base_model.dart';
import 'package:flutter_restaurant/data/model/detail_model.dart';

class ApiService {
  final Dio dio;

  ApiService({@required this.dio});

  Future<BaseModel> fetchRestaurans() async {
    final response = await dio.get('/list');
    if (response.statusCode == 200) {
      return BaseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailModel> fetchDetail(String id) async {
    final response = await dio.get('/detail/$id');
    if (response.statusCode == 200) {
      return DetailModel.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<BaseModel> searchRestaurans(String query) async {
    final response = await dio.get('//search?q=$query');
    if (response.statusCode == 200) {
      return BaseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
