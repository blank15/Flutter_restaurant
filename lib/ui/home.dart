import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/common/style.dart';
import 'package:flutter_restaurant/data/model/Restaurants.dart';
import 'package:flutter_restaurant/widget/slider_widget.dart';

class Home extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
              width: MediaQuery.of(context).size.width,
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
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 1.0,
                  color: Colors.black54,
                )
              ],
            ),
            _buildList(context),
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
            _buildList(context),
            Text(
              "More restaurant",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Container(
      height: 220,
      child: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('asset/restaurant.json'),
          builder: (context, snapshot) {
            final List<Restaurants> data = parseRestaurants(snapshot.data);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(context, data[index]);
              },
            );
          }),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurants restaurants) {
    return Container(
      height: 100,
      child: Card(
          elevation: 2,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: restaurants.id,
                  child: Image.network(
                    restaurants.pictureId,
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
    );
  }
}
