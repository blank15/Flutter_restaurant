import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/model/restaurants_model.dart';

import 'home.dart';

class DetailRestaurant extends StatelessWidget {
  static final routeName = '/detail_restaurant';
  static final imageHeader = 'image';

  final RestaurantsModel restaurants;
  // final String routeImage;
  const DetailRestaurant({@required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(headerSliverBuilder: (context,isScrolled){
        return[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(tag: '${restaurants.id}/${Home.imageNearby}', child:
              Image.network('https://restaurant-api.dicoding.dev/images/medium/${restaurants
                  .pictureId}',fit:BoxFit.cover ,)),
              title: Text(restaurants.name,style: TextStyle(color: Colors.white),),
            ),
          )
        ];
      },body: _body(context),),
    );
  }

  Widget _body(BuildContext context){
      return ListView(
        padding:const EdgeInsets.all(8),
        children: <Widget>[
          Row(
              children: [
                Icon(Icons.location_on,size: 14.0,),
                Text(restaurants.city,style: TextStyle(fontSize: 12.0,color: Colors.grey))
              ],
            ),
          Row(
            children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 14.0,
                  ),
                  Text(
                    restaurants.rating.toString(),
                  )
                ],
              ),
          Padding(padding: const EdgeInsets.all(8),
          child:
          Text(restaurants.description,style: TextStyle(color: Colors.grey),),),
          Text("Foods",style: TextStyle(fontSize: 24.0,color: Colors.green,fontWeight: FontWeight.bold),),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: Colors.green,shape: BoxShape.rectangle),
          ),
          Padding(padding:  const EdgeInsets.all(8)),
          Text("Drinks",style: TextStyle(fontSize: 24.0,color: Colors.green,fontWeight: FontWeight.bold),),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: Colors.green,shape: BoxShape.rectangle),
          ),

        ],
      );
  }

  Widget _buildListMenu(BuildContext context,String name){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name)
      ],
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(restaurants.name, textAlign: TextAlign.right),
        transitionBetweenRoutes: false,
      ),
      child: _body(context),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(headerSliverBuilder: (context,isScrolled){
        return[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(tag: restaurants.id, child:
              Image.network(restaurants.pictureId,fit:BoxFit.cover ,)),
              title: Text(restaurants.name,style: TextStyle(color: Colors.white),),
            ),
          )
        ];
      },body: _body(context),),
    );
  }
}
