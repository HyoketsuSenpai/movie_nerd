part of 'movielist_bloc.dart';

abstract class MovielistEvent extends Equatable {
  const MovielistEvent();

  @override
  List<Object> get props => [];
}

class GetMovieListEvent extends MovielistEvent {
  final int page;
  final String sortBy;
  bool clean;

  GetMovieListEvent({required this.page, required this.sortBy, this.clean = false});

  @override
  List<Object> get props => [page, sortBy];
}

class GetSearchMovieListEvent extends MovielistEvent {
  final int page;
  final String query;
  bool clean;

  GetSearchMovieListEvent({required this.page, required this.query, this.clean =  false});

  @override
  List<Object> get props => [page, query];
}
