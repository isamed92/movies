import 'package:flutter/material.dart';

import '../models/pelicula_model.dart';

class MovieHorinzontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);
  MovieHorinzontal({@required this.movies, @required this.nextPage});
  @override
  Widget build(BuildContext context) {

    _pageController.addListener( (){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        // print('cargar siguientes peliculas');
        nextPage();
      }
    });
    final _screenSize = MediaQuery.of(context).size;



    return Container(
      height: _screenSize.height * .3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _tarjetas(context),
        itemBuilder: (context, i){
          return _card(context, movies[i]);
        },
        itemCount: movies.length,
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 150.0),
            ),
            SizedBox(height: 5.0,),
            Text(movie.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,)
          ],
        ),
      );
    }).toList();
  }


  Widget _card(BuildContext context, Movie movie) {
     final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 150.0),
            ),
            SizedBox(height: 5.0,),
            Text(movie.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption,)
          ],
        ),
      );
      return GestureDetector(
        child: tarjeta,
        onTap: (){
          // print('titulo de la pelicula: ${movie.title}');
          Navigator.pushNamed(context, 'detail', arguments: movie);
        },
      );
  }
}
