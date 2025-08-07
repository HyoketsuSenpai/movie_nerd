import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_nerd/features/MovieList/presentation/bloc/movielist_bloc.dart';
import 'package:movie_nerd/features/MovieList/presentation/pages/movie_list_page.dart';
import 'package:movie_nerd/injection.dart' as di;


void main() async {
  await dotenv.load(fileName: ".env");
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  BlocProvider(
      create: (context) =>
          di.sl<MovielistBloc>()
            ..add(GetMovieListEvent(page: 1, sortBy: 'popularity.desc')), 
            child: const MovieListPage()
            ),
    );
  }
}
