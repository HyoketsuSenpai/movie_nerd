part of 'movielist_bloc.dart';

abstract class MovielistState extends Equatable {
  const MovielistState();

  @override
  List<Object> get props => [];
}

class Empty extends MovielistState {}

class Loading extends MovielistState {
  final List<Movie> oldMovies;

  const Loading({required this.oldMovies});
}

class Loaded extends MovielistState {
  final List<Movie> movies;

  const Loaded({required this.movies});
}

class Error extends MovielistState {
  final String message;

  const Error({required this.message});
}
