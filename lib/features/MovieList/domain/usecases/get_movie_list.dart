import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_nerd/core/error/failure.dart';
import 'package:movie_nerd/core/usecase/usecase.dart';
import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';
import 'package:movie_nerd/features/MovieList/domain/repositories/movie_repository.dart';

class GetMovieList extends Usecase<List<Movie>,Params>{

  final MovieRepository repository;

  GetMovieList({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> call(Params params) async {
    return await repository.getMovieList(params.page,params.sortBy);
  }
}

class Params extends Equatable {
  final int page;
  final String sortBy;

  const Params({required this.page, required this.sortBy});
  
  @override
  List<Object?> get props => [page, sortBy];
}