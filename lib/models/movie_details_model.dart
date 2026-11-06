class CastModel {
  final String name;
  final String character;
  final String? image;

  CastModel({required this.name, required this.character, this.image});

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      character: json['character_name'] ?? '',
      image: json['url_small_image'],
    );
  }
}

class MovieDetailsModel {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final int likeCount;
  final String summary;
  final List<String> genres;
  final String background;
  final String cover;
  final List<String> screenshots;
  final List<CastModel> cast;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.summary,
    required this.genres,
    required this.background,
    required this.cover,
    required this.screenshots,
    required this.cast,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      summary: json['description_full'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      background: json['background_image'] ?? '',
      cover: json['medium_cover_image'] ?? '',
      screenshots: [1, 2, 3]
          .map((i) => json['large_screenshot_image$i'])
          .whereType<String>()
          .toList(),
      cast: (json['cast'] as List? ?? [])
          .map((c) => CastModel.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}