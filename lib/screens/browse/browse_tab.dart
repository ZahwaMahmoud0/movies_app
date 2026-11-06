import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/movie_card.dart';
import '../../models/movie_model.dart';
import '../../services/movies_api.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  static const _genres = [
    'Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime',
    'Documentary', 'Drama', 'Family', 'Fantasy', 'Horror', 'Mystery',
    'Romance', 'Sci-Fi', 'Thriller', 'War',
  ];

  String _genre = 'Action';
  late Future<List<MovieModel>> _future = _load();

  Future<List<MovieModel>> _load() =>
      MoviesApi.getMovies(genre: _genre.toLowerCase(), limit: 30);

  Widget _chip(String g) {
    final selected = g == _genre;
    return GestureDetector(
      onTap: () => setState(() {
        _genre = g;
        _future = _load();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.yellow : null,
          border: Border.all(color: AppColors.yellow, width: 1.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(g,
            style: TextStyle(
              color: selected ? AppColors.black : AppColors.yellow,
              fontWeight: FontWeight.w700,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16).copyWith(top: 0, bottom: 0),
            itemCount: _genres.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, i) => _chip(_genres[i]),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: FutureBuilder<List<MovieModel>>(
            future: _future,
            builder: (_, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.yellow));
              }
              if (snap.hasError) {
                return Center(
                  child: TextButton(
                    onPressed: () => setState(() => _future = _load()),
                    child: const Text('Retry'),
                  ),
                );
              }
              final movies = snap.data!;
              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemCount: movies.length,
                itemBuilder: (_, i) => MovieCard(movie: movies[i]),
              );
            },
          ),
        ),
      ]),
    );
  }
}