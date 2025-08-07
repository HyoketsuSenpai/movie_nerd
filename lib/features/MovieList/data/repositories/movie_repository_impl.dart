import 'package:dartz/dartz.dart';
import 'package:movie_nerd/core/error/exception.dart';
import 'package:movie_nerd/core/error/failure.dart';
import 'package:movie_nerd/features/MovieList/data/datasources/movie_list_remote_data_source.dart';
import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';
import 'package:movie_nerd/features/MovieList/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository{

  final MovieListRemoteDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Movie>>> getMovieList(int page, String sortBy) async {
    try {
      return Right(await dataSource.getMovieList(page, sortBy));
    }
    on ServerException {
      return Left(ServerFailure(message: 'SERVER_ERROR'));
    }
  }
  
  @override
  Future<Either<Failure, List<Movie>>> getSearchMovieList(int page, String query) async {
    try {
      return Right(await dataSource.getSearchMovieList(page, query));
    } on ServerException {
      return Left(ServerFailure(message: 'SERVER_ERROR'));
    }
  }
}