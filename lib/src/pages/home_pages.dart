import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final provider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Peliculas en cines'),
            backgroundColor: Colors.indigoAccent,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ]),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context)
             ]
          )
        )
);
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: provider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(height: 300.0, child: Center(child: CircularProgressIndicator()));
        }
      }
    );
    // provider.getNowPlaying();
    // return CardSwiper(movies: [1]);
  }
  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(children: <Widget>[
        Text('Populares', style: Theme.of(context).textTheme.subhead),
        FutureBuilder(
          future: provider.getPopular(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if(snapshot.hasData) return CardSwiper(movies: snapshot.data);
            else {
              return Container(height: 300.0, child: Center(child: CircularProgressIndicator()));
            }
          }
        )
      ],),
    );
  }


}


