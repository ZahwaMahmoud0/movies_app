
import 'package:flutter/material.dart';
import '../../models/movie_details_model.dart';
import '../../services/movies_api.dart';

const _bg = Color(0xFF1B1B1D);
const _card = Color(0xFF2C2C2E);
const _yellow = Color(0xFFF6BD00);

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsModel? movie;
  List<MovieDetailsModel> similar = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final results = await Future.wait([
        MoviesApi.getMovieDetails(widget.movieId),
        MoviesApi.getMovieSuggestions(widget.movieId),
      ]);

      movie = results[0] as MovieDetailsModel;
      similar = results[1] as List<MovieDetailsModel>;
    } catch (e) {
      error = 'Something went wrong';
    }

    if (!mounted) return;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: _body(),
    );
  }

  Widget _body() {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.red),
      );
    }

    if (error != null || movie == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error ?? 'No data',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _load,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final m = movie!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(movie: m),

          _ActionsSection(movie: m),

          if (m.screenshots.isNotEmpty) ...[
            const _SectionTitle('Screen Shots'),
            _ScreenShots(urls: m.screenshots),
          ],

          if (similar.isNotEmpty) ...[
            const _SectionTitle('Similar'),
            _SimilarGrid(movies: similar),
          ],

          const _SectionTitle('Summary'),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              m.summary,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),

          if (m.cast.isNotEmpty) ...[
            const _SectionTitle('Cast'),
            _CastList(cast: m.cast),
          ],

          const _SectionTitle('Genres'),
          _GenreChips(genres: m.genres),
        ],
      ),
    );
  }
}

// ---------- Header ----------

class _Header extends StatelessWidget {
  final MovieDetailsModel movie;

  const _Header({required this.movie});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.75;
    final top = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            movie.background.isNotEmpty
                ? movie.background
                : movie.cover,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (_, _, _) =>
                Container(color: const Color.fromARGB(255, 215, 215, 215)),
          ),

          // Gradient
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.4, 1.0],
                colors: [
                  Colors.black38,
                  Colors.transparent,
                  _bg,
                ],
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),

          // Bookmark Button
          Positioned(
            top: top + 8,
            right: 8,
            child: IconButton(
              icon: const Icon(
                Icons.bookmark,
                size: 22,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),

          // Play Button
          Center(
            child: Container(
              width: 97,
              height: 97,
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: _yellow,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: _yellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),

          // Movie Title & Year
          Positioned(
            left: 16,
            right: 16,
            bottom: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.39,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${movie.year}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(247, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Watch + Statistics ----------

class _ActionsSection extends StatelessWidget {
  final MovieDetailsModel movie;

  const _ActionsSection({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          // Watch Button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE82626),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Watch',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Statistics
          Row(
            children: [
              Expanded(
                child: _StatChip(
                  icon: Icons.favorite,
                  text: '${movie.likeCount}',
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _StatChip(
                  icon: Icons.access_time_filled,
                  text: '${movie.runtime}',
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _StatChip(
                  icon: Icons.star,
                  text: '${movie.rating}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------- Statistics Chip ----------

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StatChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            color: _yellow,
            size: 26,
          ),

          const SizedBox(width: 8),

          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Section Title ----------

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ---------- Screen Shots ----------

class _ScreenShots extends StatelessWidget {
  final List<String> urls;

  const _ScreenShots({required this.urls});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: urls
            .map(
              (url) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 2.3,
                    child: Image.network(
                      url,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: Colors.grey[800]),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ---------- Similar Movies ----------

class _SimilarGrid extends StatelessWidget {
  final List<MovieDetailsModel> movies;

  const _SimilarGrid({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: movies.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, i) {
          final item = movies[i];

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    MovieDetailsScreen(movieId: item.id),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.cover,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(color: Colors.grey[800]),
                  ),

                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${item.rating}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 3),

                          const Icon(
                            Icons.star,
                            size: 13,
                            color: _yellow,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------- Cast ----------

class _CastList extends StatelessWidget {
  final List<CastModel> cast;

  const _CastList({required this.cast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: cast
            .map(
              (m) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[800],
                      backgroundImage: m.image != null
                          ? NetworkImage(m.image!)
                          : null,
                      child: m.image == null
                          ? const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )
                          : null,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name : ${m.name}',
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Character : ${m.character}',
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ---------- Genres ----------

class _GenreChips extends StatelessWidget {
  final List<String> genres;

  const _GenreChips({required this.genres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: genres
            .map(
              (g) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  g,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
