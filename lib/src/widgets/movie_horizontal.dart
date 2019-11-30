import 'package:flutter/material.dart';

import '../models/pelicula_model.dart';

class MovieHorinzontal extends StatelessWidget {
  final List<Movie> movies;

  MovieHorinzontal({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * .3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _tarjetas(context),
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
}
