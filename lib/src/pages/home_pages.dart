import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search),
            onPressed: () {}
          )
        ]
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
          ]
        )
      )
    );
  }


  Widget _swiperTarjetas(){
    return Container(
      width: double.infinity,
      height: 300.0,
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            return Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
          },
          itemCount: 3,
          itemWidth: 200.0,
          layout: SwiperLayout.STACK,
          // pagination: SwiperPagination(),
          // control: SwiperControl(),
        ),
    );
  }

}