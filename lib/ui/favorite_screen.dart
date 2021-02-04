import 'package:flutter/material.dart';


class FavoriteScreen extends StatefulWidget {
  static final routeName = '/favorite';
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
      body: Container(
      ),
    );
  }
}
