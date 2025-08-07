import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_nerd/core/error/exception.dart';
import 'package:movie_nerd/features/MovieList/data/models/movie_model.dart';

abstract class MovieListRemoteDataSource {
  //Add documentation bruv
  Future<List<MovieModel>> getMovieList(int page, String sortBy);
  Future<List<MovieModel>> getSearchMovieList(int page, String query);
}

class MovieListRemoteDataSourceImpl implements MovieListRemoteDataSource {
  final http.Client client;
  final String apiKey;

  MovieListRemoteDataSourceImpl({required this.client, required this.apiKey});

  @override
  Future<List<MovieModel>> getMovieList(int page, String sortBy) async {
    final uri = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$page&sort_by=$sortBy',
    );
    return await movieList(uri);
  }

  @override
  Future<List<MovieModel>> getSearchMovieList(int page, String query) async {
    final uri = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&language=en-US&page=$page',
    );
    return await movieList(uri);
  }

  Future<List<MovieModel>> movieList(Uri uri) async {
    final response = await client.get(
      uri,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> moviesMap = jsonMap['results'];
      final List<MovieModel> movies = moviesMap
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      return movies;
    } else {
      throw ServerException();
    }
  }
}
