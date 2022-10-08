import 'package:movies_list/api/api_base.dart';
import 'package:movies_list/apiKey.dart';
import 'package:movies_list/models/moviedb_response.dart';

class MovieSearchRepository {
  final String _accessToken = accessToken ??
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjllYWE2MmVjZjQ2MTQ0NjliMTQxY2FhMDNlNDU1YSIsInN1YiI6IjYzNDA0MTIxNDM1MDExMDA3ZmQ1NzRmMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LptYKzE6f2N-4ePLk41L3IcutQSjYkcLrThU3D5QLDc";
  final ApiBase _apiBase;

  MovieSearchRepository({ApiBase? apiBase}) : _apiBase = apiBase ?? ApiBase();

  Future<List<Movie>> searchMovies({required String query}) async {
    final response = await _apiBase.search_query(query, _accessToken);
    return MovieDbResponse.fromMap(response).movies;
  }
}
