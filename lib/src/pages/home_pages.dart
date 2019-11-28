import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Peliculas en cines'),
            backgroundColor: Colors.indigoAccent,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ]),
        body: Container(child: Column(children: <Widget>[_swiperTarjetas()])));
  }

  Widget _swiperTarjetas() {
    final provider = MoviesProvider();
    provider.getNowPlaying();
    return CardSwiper(
      movies: [1]
    );
  }
}
