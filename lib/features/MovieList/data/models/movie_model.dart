import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.voteTarget,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path']??'',
      genreIds: List<int>.from(json['genre_ids'])??[],
      id: json['id']??0,
      originalTitle: json['original_title']??'',
      overview: json['overview']??'',
      popularity: json['popularity']??0.0,
      posterPath: json["poster_path"]??'',
      releaseDate: json['release_date']??'',
      title: json['title'] ?? '',
      voteTarget: json['vote_average']??0.0,
      voteCount: json['vote_count']??0,
    );
  }
}
