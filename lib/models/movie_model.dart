class MovieModel {
  final int id;
  final String title;
  final double rating;
  final String cover;
  final String largeCover;

  const MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.cover,
    required this.largeCover,
  });

  factory MovieModel.fromJson(Map<String, dynamic> j) => MovieModel(
        id: j['id'] ?? 0,
        title: j['title'] ?? '',
        rating: (j['rating'] ?? 0).toDouble(),
        cover: j['medium_cover_image'] ?? '',
        largeCover: j['large_cover_image'] ?? '',
      );
}