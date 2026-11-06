import 'package:flutter/material.dart';
import '../../models/movie_model.dart';
import '../../screens/movie_details/movie_details_screen.dart';
import '../app_colors.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final double? width;
  final VoidCallback? onTap;

  const MovieCard({super.key, required this.movie, this.width, this.onTap});

  void _open(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movieId: movie.id)),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => _open(context),
      child: SizedBox(
        width: width,
        child: Stack(children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ColoredBox(
                color: AppColors.field,
                child: Image.network(
                  movie.cover,
                  fit: BoxFit.cover,
                  cacheWidth: 400,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.movie, color: AppColors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text('${movie.rating}',
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(width: 4),
                const Icon(Icons.star, color: AppColors.yellow, size: 14),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}