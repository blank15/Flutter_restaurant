import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';
import 'package:flutter_restaurant/common/style.dart';
import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';
import 'package:flutter_restaurant/ui/favorite_screen.dart';
import 'package:flutter_restaurant/ui/search_screen.dart';
import 'package:flutter_restaurant/ui/setting_screen.dart';
import 'package:flutter_restaurant/widget/slider_widget.dart';
import 'package:flutter_restaurant/widget/start_rating.dart';

import 'detail_restaurant_screen.dart';

class Home extends StatefulWidget {
  static const routeName = '/home_page';
  static const imageNearby = '/nearby';
  static const imaageRecommended = '/recommended';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<RestaurantEntity> dataList = List<RestaurantEntity>();

  @override
  void initState() {
    super.initState();
    context.read<RestaurantBloc>()..add(FetchRestaurant());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: RichText(
            text: TextSpan(
                style: Theme.of(context)
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
              onPressed: () {
                Navigator.pushNamed(context, FavoriteScreen.routeName);
              },
            ),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                }),
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: ListView(shrinkWrap: true, physics: ScrollPhysics(), children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SearchView.routeName);
              },
              child: Container(
                margin: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: colorGrey,
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
            ),
            SliderWidget(),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 24.0, right: 8.0),
                  child: Text(
                    "Nearby",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 1.0,
                  color: Colors.grey,
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
                  color: Colors.grey,
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
      ]),
    );
  }

  Widget _buildListMoreRestaurant(BuildContext context) {
    return Container(
      height: 220,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
        if (state is RestaurantSuccess) {
          final List<RestaurantEntity> data = state.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 9,
            itemBuilder: (context, index) {
              return _buildRestaurantItemMore(context, data[index]);
            },
          );
        } else if (state is RestaurantLoading) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ));
        } else if (state is RestaurantNoInternet) {
          return Text("No Internet Connection");
        } else {
          return Text("Failed get Content $state");
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
          final List<RestaurantEntity> data = state.data;
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
              child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ));
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
      height: 250,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
        if (state is RestaurantSuccess) {
          dataList = state.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildRestaurantRecomended(context, dataList[index]);
            },
          );
        } else if (state is RestaurantLoading) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ));
        } else if (state is RestaurantNoInternet) {
          return Text("No Internet Connection");
        } else {
          return Text("Failed get Content");
        }
      }),
    );
  }

  Widget _buildRestaurantRecomended(
      BuildContext context, RestaurantEntity restaurants) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurant.routeName,
            arguments: restaurants);
      },
      child: Container(
        height: 100,
        child: Stack(children: [
          Card(
              elevation: 1,
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                      tag: '${restaurants.id}/${Home.imaageRecommended}',
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}',
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
              )),
          Container(
            margin: EdgeInsets.all(10),
            height: 25,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(5.0)),
            ),
            child: Text(
              "Promo",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildRestaurantItem(
      BuildContext context, RestaurantEntity restaurants) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurant.routeName,
            arguments: restaurants);
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
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}',
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

  Widget _buildRestaurantItemMore(
      BuildContext context, RestaurantEntity restaurants) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurant.routeName,
            arguments: restaurants);
      },
      child: Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      child: Hero(
                          tag: restaurants.id,
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                          child: Text(
                            restaurants.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                          child: Row(
                            children: [
                              Text(restaurants.city,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StarRating(
                                rating: restaurants.rating,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(restaurants.rating.toString(),
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                  margin: EdgeInsets.only(top: 8.0),
                )
              ],
            ),
          )),
    );
  }
}
