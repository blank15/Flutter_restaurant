import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';
import 'package:flutter_restaurant/common/style.dart';
import 'package:flutter_restaurant/data/model/restaurants_model.dart';
import 'package:flutter_restaurant/widget/slider_widget.dart';

import 'detail_restaurant.dart';

class Home extends StatefulWidget {
  static const routeName = '/home_page';
  static const imageNearby ='/nearby';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<RestaurantsModel> dataList = List<RestaurantsModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: RichText(
            text: TextSpan(
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: "Nameless", style: TextStyle(color: colorPrimary)),
                  TextSpan(text: "Food", style: TextStyle(color: Colors.green)),
                ]),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.black12,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Cari Restaurant",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SliderWidget(),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, top: 24.0, right: 8.0),
                  child: Text(
                    "Nearby !",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.65,
                  height: 1.0,
                  color: Colors.black54,
                )
              ],
            ),
            _buildListNearby(context),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, top: 24.0, right: 8.0),
                  child: Text(
                    "Recomended",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  width: 250,
                  height: 1.0,
                  color: Colors.black54,
                )
              ],
            ),
            _buildListRecomended(context),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 24.0, right: 8.0),
              child: Text(
                "More restaurant",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            _buildListMoreRestaurant(context)
          ],
        ),
      ),
    );
  }

  Widget _buildListMoreRestaurant(BuildContext context) {
    return Container(
      height: 220,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantSuccess) {
              final List<RestaurantsModel> data = state.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItemMore(context, data[index]);
                },
              );
            } else if (state is RestaurantLoading) {
              return Center(
                child: CircularProgressIndicator( backgroundColor: Colors.green,)
              );
            } else if (state is RestaurantNoInternet) {
              return Text("No Internet Connection");
            } else {
              return Text("Failed get Content");
            }
          }),
    );
  }

  Widget _buildListNearby(BuildContext context) {
    return Container(
      height: 220,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantSuccess) {
              final List<RestaurantsModel> data = state.data;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, data[index]);
                },
              );
            } else if (state is RestaurantLoading) {
              return Center(
                  child: CircularProgressIndicator( backgroundColor: Colors.green,)
              );
            } else if (state is RestaurantNoInternet) {
              return Text("No Internet Connection");
            } else {
              return Text("Failed get Content");
            }
          }),
    );
  }

  Widget _buildListRecomended(BuildContext context) {
    return Container(
      height: 220,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantSuccess) {
              final List<RestaurantsModel> data = state.data.reversed.toList();
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildRestaurantRecomended(context, data[index]);
                },
              );
            } else if (state is RestaurantLoading) {
              return Center(
                  child: CircularProgressIndicator( backgroundColor: Colors.green,)
              );
            } else if (state is RestaurantNoInternet) {
              return Text("No Internet Connection");
            } else {
              return Text("Failed get Content");
            }
          }),
    );
  }

  Widget _buildRestaurantRecomended(BuildContext context,
      RestaurantsModel restaurants) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, DetailRestaurant.routeName, arguments: restaurants);
      },
      child: Container(
        height: 100,
        child: Stack(
            children: [Card(
                elevation: 2,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: restaurants.id,
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurants
                              .pictureId}',
                          fit: BoxFit.cover,
                          height: 150,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        restaurants.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )),
              Container(
                margin: EdgeInsets.all(10),
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5.0)),
                ),
                child: Text("Promo",
                  style: TextStyle(color: Colors.white, fontSize: 16),),
              )
            ]),
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context,
      RestaurantsModel restaurants) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, DetailRestaurant.routeName, arguments: restaurants);
      },
      child: Container(
        height: 100,
        child: Card(
            elevation: 2,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                    tag: '${restaurants.id}/${Home.imageNearby}',
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurants
                          .pictureId}',
                      fit: BoxFit.cover,
                      height: 150,
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    restaurants.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildRestaurantItemMore(BuildContext context,
      RestaurantsModel restaurants) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context, DetailRestaurant.routeName, arguments: restaurants);
      },
      child: Container(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  child: Hero(
                      tag: restaurants.id,
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/medium/${restaurants
                            .pictureId}',
                        fit: BoxFit.cover,
                        height: 150,
                      )),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      restaurants.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14.0,
                      ),
                      Text(restaurants.city,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey))
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
                ],
              )
            ],
          )),
    );
  }

}
