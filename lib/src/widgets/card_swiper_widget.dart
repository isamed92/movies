import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class CardSwiper extends StatelessWidget {
  final List<dynamic> movies;


  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context){
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top:20.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth:  _screenSize.width * 0.7,
        itemHeight: _screenSize.height* 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network('https://assets.coingecko.com/coins/images/8758/large/ShitCoin.png?1561601773', fit: BoxFit.cover)
            
          );
        },
        itemCount: movies.length,
        // pagination: SwiperPagination(),
        // control: SwiperControl(color: Colors.blueAccent),
        )
      );
  }
}