import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';
import 'package:movie_nerd/features/MovieList/domain/usecases/get_movie_list.dart' as get_movie_list;
import 'package:movie_nerd/features/MovieList/domain/usecases/get_search_movie_list.dart' as get_search_movie_list;

part 'movielist_event.dart';
part 'movielist_state.dart';

class MovielistBloc extends Bloc<MovielistEvent, MovielistState> {
  final get_movie_list.GetMovieList getMovieList;
  final get_search_movie_list.GetSearchMovieList getSearchMovieList;

  MovielistBloc(this.getMovieList, this.getSearchMovieList) : super(Empty()) {
    on<GetMovieListEvent>((event, emit) async {
      final currentState = state;
      List<Movie> oldMovies = [];
      if (currentState is Loaded && !event.clean) {
        oldMovies = currentState.movies;
      }
      emit(Loading(oldMovies: oldMovies));
      final moviesOrError = await getMovieList(
        get_movie_list.Params(page: event.page, sortBy: event.sortBy),
      );

      moviesOrError.fold(
        (error) => emit(Error(
          message: error.message)),
        (movies) => emit(Loaded(movies: [...oldMovies, ...movies])),
      );
    });
  
  
    on<GetSearchMovieListEvent>((event, emit)async {
      final currentState = state;
      List<Movie> oldMovies = [];
      if (currentState is Loaded && !event.clean) {
        oldMovies = currentState.movies;
      }
      emit(Loading(oldMovies: oldMovies));
      final moviesOrError = await getSearchMovieList(
        get_search_movie_list.Params(page: event.page, query: event.query),
      );

      moviesOrError.fold(
        (error) => emit(Error(message: error.message)),
        (movies) => emit(Loaded(movies: [...oldMovies, ...movies])),
      );
    });
  }
}
