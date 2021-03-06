import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';
import '../models/actores_model.dart';


class MoviesProvider {
  String _apikey = 'cd8faef5c9b47fd260a88b5671d77162';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popularMovies = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularMoviesStream => _popularStreamController.stream;



  void disposeStreams(){
    _popularStreamController?.close();
  }

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

    if(_loading) return [];
    _loading = true;

    // print('cargando siguiente pagina');
    _popularPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'    :  _apikey,
      'language'   :  _language,
      'page'       : _popularPage.toString()
    });
    final resp = await _procesarRespuesta(url);
    _popularMovies.addAll(resp);
    popularMoviesSink(_popularMovies);
    _loading = false;
    return resp;
  }

  Future<List<Actor>> getCast(String movieId) async{
    final url =  Uri.https(_url, '/3/movie/$movieId/credits', {
      'api_key'     : _apikey,
      'language'    : _language
    });

    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    print(cast);

    return cast.actores;


  }

  Future<List<Movie>> searchMovie(String query)  async{
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key'     : _apikey,
      'language'    : _language,
      'query'       : query
    });
    return await _procesarRespuesta(url);
  }

}