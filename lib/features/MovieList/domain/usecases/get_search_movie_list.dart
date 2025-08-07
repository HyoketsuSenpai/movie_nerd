import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_nerd/core/error/failure.dart';
import 'package:movie_nerd/core/usecase/usecase.dart';
import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';
import 'package:movie_nerd/features/MovieList/domain/repositories/movie_repository.dart';

class GetSearchMovieList extends Usecase<List<Movie>, Params> {
  final MovieRepository repository;

  GetSearchMovieList({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> call(Params params) async {
    return await repository.getSearchMovieList(params.page, params.query);
  }
}

class Params extends Equatable {
  final int page;
  final String query;

  const Params({required this.page, required this.query});

  @override
  List<Object?> get props => [page, query];
}
