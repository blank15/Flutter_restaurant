
import 'package:flutter_restaurant/data/model/Restaurants.dart';

class BaseModel{
  bool error;
  String message;
  String count;
  List<Restaurants> restaurants;

  BaseModel({this.error,this.message,this.count,this.restaurants});

  BaseModel.fromJson(Map<String, dynamic> json) {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['count'] = this.count;
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }

  }

}