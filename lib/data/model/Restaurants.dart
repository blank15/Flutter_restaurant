import 'dart:convert';

import 'Menus.dart';

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  Restaurants(
      {this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.rating,
        this.menus});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
    menus = json['menus'] != null ? new Menus.fromJson(json['menus']) : null;
  }

}
List<Restaurants> parseRestaurants(String json){
  if(json == null){
    return [];
  }

  final  Map<String,dynamic> parsed = jsonDecode(json);
  return parsed["restaurants"].map<Restaurants>((json) => Restaurants.fromJson(json)).toList() ;

}