import 'package:flutter_restaurant/data/model/foods.dart';

import 'drinks.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List<Foods>();
      json['foods'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = new List<Drinks>();
      json['drinks'].forEach((v) {
        drinks.add(new Drinks.fromJson(v));
      });
    }
  }
}