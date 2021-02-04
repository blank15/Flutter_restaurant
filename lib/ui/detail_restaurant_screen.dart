import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant/bloc/bloc.dart';
import 'package:flutter_restaurant/bloc/detail_restaurant/detail_bloc.dart';
import 'package:flutter_restaurant/domain/entity/drinks_entity.dart';
import 'package:flutter_restaurant/domain/entity/food_entity.dart';
import 'package:flutter_restaurant/domain/entity/restaurant_entity.dart';
import 'package:flutter_restaurant/widget/start_rating.dart';

class DetailRestaurant extends StatefulWidget {
  static final routeName = '/detail_restaurant';
  static final imageHeader = 'image';

  final RestaurantEntity restaurants;

  // final String routeImage;
  const DetailRestaurant({@required this.restaurants});

  @override
  _DetailRestaurantState createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {

  bool _isFavorite = false;
  IconData _iconFavorite =  Icons.favorite_border;
  RestaurantEntity data;
  @override
  void initState() {
    super.initState();
    context.read<DetailBloc>()
      ..add(FetchDetailRestaurant(id: widget.restaurants.id));
  }

  _setFavorite(){
    setState(() {
      _isFavorite =! _isFavorite;
      if(_isFavorite){
       if(data !=null){
         context.read<DetailBloc>()
           ..add(SaveRestaurant(data: data));
       }
        _iconFavorite =  Icons.favorite;
      }else{
        _iconFavorite = Icons.favorite_border;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://restaurant-api.dicoding.dev/images/medium/${widget.restaurants.pictureId}',
                      ),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      IconButton(
                          icon: Icon(
                            _iconFavorite,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            _setFavorite();
                          })
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _bodyWithData(context)
          ],
        ),
      )),
    );
  }

  Widget _bodyWithData(BuildContext context) {
    return Container(
      height: 4000,
      child: BlocBuilder<DetailBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantSuccess) {
            data = state.data;
            debugPrint('data ${state.data}');
            _isFavorite = data.isFavorite;
            return _body(context, data);
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
        },
      ),
    );
  }

  Widget _body(BuildContext context, RestaurantEntity data) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  width: 120,
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: Container(
                    padding: EdgeInsets.all(3.0),
                    width: 100,
                    height: 40,
                    child: Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.categoryEntity.length,
                          itemBuilder: (context, index) {
                            return Center(
                                child:
                                    Text('${data.categoryEntity[index].name}, ',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )));
                          }),
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 16.0,
              ),
              Text(data.city,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey)),
              Spacer(),
              StarRating(
                rating: data.rating,
                color: Colors.green,
              ),
              Text(data.rating.toString(),
                  style: TextStyle(fontSize: 16.0, color: Colors.black))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            data.description,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Text(
            "Foods",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: data.menus.foods.length,
            itemBuilder: (context, index) {
              return _buildFoods(context, data.menus.foods[index]);
            }),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Text(
            "Drinks",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: data.menus.drinks.length,
            itemBuilder: (context, index) {
              return _buildDrinks(context, data.menus.drinks[index]);
            })
      ],
    );
  }

  Widget _buildFoods(BuildContext context, FoodEntity foodsModel) {
    return Container(
        height: 150,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    child: Image.network(
                      'https://images.squarespace-cdn.com/content/v1/5613e00fe4b00eddcf328662/1449789470175-1JZ08ZTOG4SOTW482BON/ke17ZwdGBToddI8pDm48kMogPkvWiQL7JS4JJSeltxpZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpyHiAElW6fjxk3QJsBympvZcg56S3kJvI38owpgO-XPNOajKssE4pJRRaa7jBk9aBg/The-Care-For-Skin-Foundation-Food-Icon.png',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Text(
                          foodsModel.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
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
        ));
  }

  Widget _buildDrinks(BuildContext context, DrinkEntity drinkModel) {
    return Container(
        height: 150,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    child: Image.network(
                      'https://www.iconbunny.com/icons/media/catalog/product/2/4/2453.11-drinks-icon-iconbunny.jpg',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Text(
                          drinkModel.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
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
        ));
  }
}
