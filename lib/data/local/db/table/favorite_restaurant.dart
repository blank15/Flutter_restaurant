import 'package:moor/moor.dart';

class FavoriteRestaurant extends Table {
  @override
  String get tableName => 'FavoriteRestaurant';

  TextColumn get id => text().named('id')();

  TextColumn get name => text().named('name')();

  TextColumn get description => text().named('description')();

  TextColumn get pictureId => text().named('pictureId')();

  TextColumn get city => text().named('city')();

  TextColumn get rating => text().named('rating')();

  TextColumn get jsonMenus => text().named('jsonMenus')();

  TextColumn get jsonCategories => text().named('jsonCategories')();

  @override
  Set<Column> get primaryKey => {id};
}
