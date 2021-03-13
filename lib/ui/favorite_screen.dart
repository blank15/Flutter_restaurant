import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_restaurant/bloc/favorite/favorite_event.dart';
import 'package:flutter_restaurant/bloc/favorite/favorite_state.dart';

import '../domain/entity/restaurant_entity.dart';
import '../widget/start_rating.dart';
import 'detail_restaurant_screen.dart';


class FavoriteScreen extends StatefulWidget {
  static final routeName = '/favorite';
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}




class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>()
      ..add(FetchListFavorite());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'Favorite',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:  BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is SuccessGetListFavorite) {
              final List<RestaurantEntity> data = state.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, data[index]);
                },
              );
            } else if (state is FavoriteLoading) {
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ));
            } else {
              return Text("Failed get Content in state: $state");
            }
          }),
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
