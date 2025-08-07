import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_nerd/features/MovieList/domain/entities/movie.dart';

import '../../data/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  static const Map<int, String> genres = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };


  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title, overflow: TextOverflow.ellipsis)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
              placeholder: (context, url) => Container(
                height: 220,
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 220,
                color: Colors.grey,
                child: const Center(child: Icon(Icons.broken_image)),
              ),
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                 
                  Text(
                    'Release Date: ${movie.releaseDate}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),

                  
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 24),
                      
                      const SizedBox(width: 10),
                      Text('(${movie.voteCount} votes)'),
                    ],
                  ),
                  const SizedBox(height: 16),

                 
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  
                  const SizedBox(height: 20),
                  Text(
                    'Genres: ${movie.genreIds.map((id) => genres[id]).whereType<String>().join(", ")}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
