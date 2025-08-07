import 'package:dartz/dartz.dart';
import 'package:movie_nerd/core/error/failure.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure,List<Movie>>> getMovieList(int page, String sortBy);

  Future<Either<Failure, List<Movie>>> getSearchMovieList(int page, String query);
}