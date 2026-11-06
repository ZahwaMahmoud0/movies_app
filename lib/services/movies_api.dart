import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import '../models/movie_details_model.dart';

class MoviesApi {
  static const _bases = [
    'https://movies-api.accel.li/api/v2',
    'https://yts.gg/api/v2',
  ];

  static Future<dynamic> _get(String endpoint, Map<String, String> params) async {
    Object? lastError;
    for (final base in _bases) {
      try {
        final uri = Uri.parse('$base/$endpoint').replace(queryParameters: params);
        final res = await http.get(uri).timeout(const Duration(seconds: 10));
        if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
        final body = jsonDecode(res.body);
        if (body['status'] != 'ok') throw Exception(body['status_message']);
        return body['data'];
      } catch (e) {
        lastError = e;
      }
    }
    throw Exception('$lastError');
  }

 static Future<List<MovieModel>> getMovies({
  String? genre,
  String? query,
  int limit = 10,
}) async {
  final data = await _get('list_movies.json', {
    'limit': '$limit',
    'genre': ?genre,
    'query_term': ?query,
  });
  final list = data['movies'] as List? ?? [];
  return list.map((e) => MovieModel.fromJson(e)).toList();
}

  static Future<MovieDetailsModel> getMovieDetails(int id) async {
    final data = await _get('movie_details.json', {
      'movie_id': '$id',
      'with_images': 'true',
      'with_cast': 'true',
    });
    return MovieDetailsModel.fromJson(data['movie']);
  }

  static Future<List<MovieDetailsModel>> getMovieSuggestions(int id) async {
    final data = await _get('movie_suggestions.json', {'movie_id': '$id'});
    final list = data['movies'] as List? ?? [];
    return list.map((e) => MovieDetailsModel.fromJson(e)).toList();
  }
}