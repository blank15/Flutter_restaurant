import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/Restaurants.dart';
import 'package:flutter_restaurant/ui/detail_restaurant.dart';
import 'package:flutter_restaurant/widget/platform_widget.dart';

class Home extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('asset/restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurants> data = parseRestaurants(snapshot.data);
          return GridView.builder(
            itemCount: data.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, data[index]);
            },
          );
        });
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurants restaurants) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap:(){
                    Navigator.pushNamed(context, DetailRestaurant.routeName,arguments: restaurants);
                  },
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(tag:restaurants.id, child:  Image.network(restaurants.pictureId,)),
                    Text(restaurants.name),
                    Text(restaurants.city),
                    Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            Text(
                              restaurants.rating.toString(),
                            )
                          ],
                        )),

                  ],
                ),
              )

            ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant app', textAlign: TextAlign.right),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant app'),
      ),
      body: _buildList(context),
    );
  }
}
