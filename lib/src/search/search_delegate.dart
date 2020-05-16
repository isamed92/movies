import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = '';

  final peliculasProvider = new MoviesProvider();

  final peliculas = [
    'Spiderman',
    'Soy Leyenda',
    'Wolverine inmortal',
    'Guardianes de la galaxia',
    'Capitan America',
    'Hulk',
    'Iron Man',
  ];
  final peliculasRecientes = [
    'Spiderman',
    'capitan america'
  ];
 

  @override
  List<Widget> buildActions(BuildContext context) {
    //? Acciones de nuestro AppBar (por ejemplo el icono de cancelar)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          // print('CLICK!!!');
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //? Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // print('LEADING ICON PRESS');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //? Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.amberAccent,
        child: Text(seleccion),

      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //? son las sugerencias que aparecen cuando la persona escribe
    if(query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map( (pelicula) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // final listaSugerida = (query.isEmpty) ? peliculasRecientes : peliculas.where( (p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();


    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listaSugerida[i]),
    //       onTap: (){
    //         seleccion = listaSugerida[i];
    //         showResults(context); //llama al build results
    //       },
    //     );
    //   },
    // );
  }


}