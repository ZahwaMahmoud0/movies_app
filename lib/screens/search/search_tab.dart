import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/movie_card.dart';
import '../../models/movie_model.dart';
import '../../services/movies_api.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _controller = TextEditingController();
  Timer? _debounce;
  List<MovieModel> _movies = [];
  bool _loading = false;
  bool _searched = false; // اتعمل بحث فعلاً ولا لسه

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    _debounce?.cancel();
    final q = text.trim();
    if (q.isEmpty) {
      setState(() {
        _movies = [];
        _loading = false;
        _searched = false;
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () => _search(q));
  }

  Future<void> _search(String q) async {
    setState(() => _loading = true);
    try {
      final m = await MoviesApi.getMovies(query: q, limit: 30);
      if (!mounted || _controller.text.trim() != q) return;
      setState(() {
        _movies = m;
        _loading = false;
        _searched = true;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _movies = [];
          _loading = false;
          _searched = true;
        });
      }
    }
  }

  Widget _empty() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.empty,
              width: 124,
              height: 124,
              cacheWidth: 372,
              errorBuilder: (_, _, _) => const Icon(Icons.local_movies,
                  size: 90, color: AppColors.yellow),
            ),
            if (_searched) ...[
              const SizedBox(height: 12),
              const Text(
                'Not Found',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _controller,
            onChanged: _onChanged,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: AppColors.white),
              filled: true,
              fillColor: AppColors.field,
              prefixIcon: const Icon(Icons.search, color: AppColors.yellow),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.yellow))
              : _movies.isEmpty
                  ? _empty()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: _movies.length,
                      itemBuilder: (_, i) => MovieCard(movie: _movies[i]),
                    ),
        ),
      ]),
    );
  }
}