import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;


class MoviesProvider {
  String _apikey = '';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


  Future<List<Movie>> getNowPlaying()  async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'     : _apikey,
      'language'    : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final movies = Movies.fromJsonList(decodedData['results']);

    // print(movies.items[3].title);

    return movies.items;
  }

}