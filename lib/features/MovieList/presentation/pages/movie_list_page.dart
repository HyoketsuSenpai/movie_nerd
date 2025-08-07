import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';
import 'package:movie_nerd/features/MovieList/presentation/bloc/movielist_bloc.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  int page = 1;
  String filter = 'popularity.desc';

  List<String> filters = ['original_title', 'popularity', 'revenue', 'primary_release_date', 'title', 'vote_average', 'vote_count'];
  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();
  final SearchController _searchController = SearchController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= maxScroll &&
          !_scrollController.position.outOfRange) {
        page += 1;
        context.read<MovielistBloc>().add(
          _searchController.text == ''?
          GetMovieListEvent(page: page, sortBy: filter):
          GetSearchMovieListEvent(page: page, query: _searchController.text)
          ,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Nerd')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SearchBar(
                onSubmitted: (value) {
                  page = 1;
                  if(value != '') {
                  context.read<MovielistBloc>().add(GetSearchMovieListEvent(page: page, query: value,clean: true));
                  }
                  else {
                  context.read<MovielistBloc>().add(
                      GetMovieListEvent(
                        page: page,
                        sortBy: filter,
                        clean: true,
                      ),
                    );

                  }
                },
                controller: _searchController,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                leading: const Icon(Icons.search),
              ),
            ),
            ElevatedButton.icon(icon: Icon(Icons.filter_alt),onPressed: (){
              showDialog(context: context, builder: (context) {
                
              },);
            }, label: Text(filter)
            ),
            Expanded(
              child: BlocBuilder<MovielistBloc, MovielistState>(
                builder: (context, state) {
                  double deviceHeight = MediaQuery.of(context).size.height;
                  double deviceWidth = MediaQuery.of(context).size.width;
                  if (state is Loading && state.oldMovies.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
              
                  if (state is Loaded ||
                      (state is Loading && state.oldMovies.isNotEmpty)) {
                    final movies = state is Loaded
                        ? state.movies
                        : (state as Loading).oldMovies;
              
                    return GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: movies.length + (state is Loading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == movies.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return buildMovie(
                          deviceHeight,
                          deviceWidth,
                          movies[index],
                        );
                      },
                    );
                  }
              
                  if (state is Error) {
                    return Center(child: Text(state.message));
                  }
              
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMovie(double deviceHeight, double deviceWidth, Movie movie) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 231, 231, 231),
        borderRadius: BorderRadius.circular(10),
      ),
      height: deviceHeight / 3,
      width: deviceWidth / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/original${movie.posterPath}',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Flexible(
            child: Text(
              movie.originalTitle,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.thumb_up, size: deviceWidth / 30),
                  SizedBox(width: 2),
                  Text(
                    '${movie.voteCount}',
                    style: TextStyle(fontSize: deviceWidth / 30),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.star, size: deviceWidth / 30),
                  SizedBox(width: 2),
                  Text(
                    movie.popularity.toStringAsFixed(2),
                    style: TextStyle(fontSize: deviceWidth / 30),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


