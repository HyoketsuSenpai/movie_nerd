import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_nerd/features/MovieList/data/datasources/movie_list_remote_data_source.dart';
import 'package:movie_nerd/features/MovieList/data/repositories/movie_repository_impl.dart';
import 'package:movie_nerd/features/MovieList/domain/repositories/movie_repository.dart';
import 'package:movie_nerd/features/MovieList/domain/usecases/get_movie_list.dart';
import 'package:movie_nerd/features/MovieList/domain/usecases/get_search_movie_list.dart';
import 'package:movie_nerd/features/MovieList/presentation/bloc/movielist_bloc.dart';

final sl = GetIt.instance;

void init() {

  sl.registerLazySingleton(()=> http.Client());

  sl.registerLazySingleton<MovieListRemoteDataSource>(
    () => MovieListRemoteDataSourceImpl(
      client: sl(),
      apiKey: dotenv.env['API_KEY']!,
    ),
  );

  sl.registerLazySingleton<MovieRepository>(()=> MovieRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(()=> GetMovieList(repository: sl()));

  sl.registerLazySingleton(()=> GetSearchMovieList(repository: sl()));

  sl.registerFactory(() => MovielistBloc(sl(), sl()));
}
