import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/remote/model/base_model.dart';
import 'package:flutter_restaurant/data/remote/model/detail_model.dart';


abstract class ApiService {
  Future<BaseModel> fetchRestaurans();
  Future<DetailModel> fetchDetail(String id);
  Future<BaseModel> searchRestaurans(String query);
}

class ApiServiceImpl extends ApiService {
  final Dio dio;

  ApiServiceImpl({@required this.dio});

  @override
  Future<BaseModel> fetchRestaurans() async {
    final response = await dio.get('/list');
    if (response.statusCode == 200) {
      return BaseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Future<DetailModel> fetchDetail(String id) async {
    final response = await dio.get('/detail/$id');
    if (response.statusCode == 200) {
      return DetailModel.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }
  @override
  Future<BaseModel> searchRestaurans(String query) async {
    final response = await dio.get('/search?q=$query');
    if (response.statusCode == 200) {
      return BaseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
