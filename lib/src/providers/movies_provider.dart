import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;


class MoviesProvider {
  String _apikey = 'cd8faef5c9b47fd260a88b5671d77162';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;

  }


  Future<List<Movie>> getNowPlaying()  async{
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'     : _apikey,
      'language'    : _language
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'    :  _apikey,
      'language'   :  _language
    });
    return await _procesarRespuesta(url);
  }



}