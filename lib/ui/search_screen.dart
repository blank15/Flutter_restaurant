import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';
import 'package:flutter_restaurant/bloc/list_restaurant/restaurant_state.dart';
import 'package:flutter_restaurant/bloc/search_restaurant/search_restaurant.dart';
import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';
import 'package:flutter_restaurant/ui/detail_restaurant_screen.dart';
import 'package:flutter_restaurant/widget/start_rating.dart';

class SearchView extends StatefulWidget {
  static final routeName = '/search';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  context.read<SearchBloc>()
                    ..add(SearchRestaurant(query: value));
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            _buildListSearch(context)
          ],
        ),
      ),
    );
  }

  Widget _buildListSearch(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child:
            BlocBuilder<SearchBloc, RestaurantState>(builder: (context, state) {
          if (state is RestaurantSuccess) {
            final List<RestaurantEntity> data = state.data;
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
                child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ));
          } else if (state is RestaurantNoInternet) {
            return Center(child: Text("No Internet Connection"));
          } else if (state is RestaurantFailed) {
            return Center(child: Text(state.error));
          } else {
            return Center(
                child: Text(" Silahkan Melakukan Pencarian terlebih dahulu"));
          }
        }),
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
