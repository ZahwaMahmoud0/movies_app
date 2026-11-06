
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/movie_card.dart';
import '../../models/movie_model.dart';
import '../../services/movies_api.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<List<MovieModel>>> _future = _load();

  final _controller = PageController(viewportFraction: 0.5);
  int _index = 0;

  Future<List<List<MovieModel>>> _load() async {
    final action = MoviesApi.getMovies(genre: 'action')
        .catchError((_) => <MovieModel>[]);

    final featured = await MoviesApi.getMovies(limit: 8);

    return [featured, await action];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _content(
    List<MovieModel> featured,
    List<MovieModel> action,
  ) {
    const bg = AppColors.background;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            featured[_index].largeCover,
            fit: BoxFit.cover,
            cacheWidth: 200,
            errorBuilder: (_, _, _) => const SizedBox(),
          ),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  bg.withValues(alpha: 0.55),
                  bg,
                ],
              ),
            ),
          ),
        ),

        SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 8),

              Image.asset(
                AppAssets.availableNow,
                height: 55,
                cacheHeight: 165,
              ),

              const SizedBox(height: 12),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: featured.length,
                  onPageChanged: (i) {
                    setState(() => _index = i);
                  },
                  itemBuilder: (_, i) {
                    return AnimatedScale(
                      scale: i == _index ? 1 : 0.8,
                      duration: const Duration(milliseconds: 250),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: MovieCard(movie: featured[i]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Watch Now
              Image.asset(
                AppAssets.watchNow,
                height:120,
                cacheHeight: 360,
              ),

              const SizedBox(height: 18),

              // Action Section
              if (action.isNotEmpty)
                _Section(
                  title: 'Action',
                  movies: action,
                ),

              const SizedBox(height: 90),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<MovieModel>>>(
      future: _future,
      builder: (_, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellow,
            ),
          );
        }

        if (snap.hasError ||
            snap.data == null ||
            snap.data!.first.isEmpty) {
          return Center(
            child: TextButton(
              onPressed: () {
                setState(() => _future = _load());
              },
              child: const Text('Retry'),
            ),
          );
        }

        final [featured, action] = snap.data!;

        return _content(featured, action);
      },
    );
  }
}

// Section
class _Section extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;

  const _Section({
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),

              // See More
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'See More',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.yellow,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.yellow,
                    size: 23,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 172,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            separatorBuilder: (_, _) =>
                const SizedBox(width: 12),
            itemBuilder: (_, i) {
              return MovieCard(
                movie: movies[i],
                width: 115,
              );
            },
          ),
        ),
      ],
    );
  }
}
