import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final List<String> imgList = [
  'https://assets.grab.com/wp-content/uploads/sites/9/2020/06/24152020/GF_MFP_JUNI_BLOG.jpg',
  'https://assets.grab.com/wp-content/uploads/sites/9/2020/03/30123959/National-Blog-Semua-Bisa-BM-April-1440x700.jpg',
  'https://assets.grab.com/wp-content/uploads/sites/9/2020/08/13164514/1440x700-Blog_diskon-kilat-satu7an.jpg',
  'https://pbs.twimg.com/media/C7MM6DNV4AAT_DA.jpg',
];

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 15.0,
                height: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.lightGreen : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        width: 1200.0,
                        height: 300.0,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(

                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
