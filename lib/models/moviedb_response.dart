import 'dart:convert';

MovieDbResponse movieDbResponseFromMap(String str) =>
    MovieDbResponse.fromMap(json.decode(str));

String movieDbResponseToMap(MovieDbResponse data) => json.encode(data.toMap());

class MovieDbResponse {
  MovieDbResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Movie> movies;
  final int totalPages;
  final int totalResults;

  MovieDbResponse copyWith({
    int? page,
    List<Movie>? movies,
    int? totalPages,
    int? totalResults,
  }) =>
      MovieDbResponse(
        page: page ?? this.page,
        movies: movies ?? this.movies,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MovieDbResponse.fromMap(Map<String, dynamic> json) => MovieDbResponse(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(movies.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Movie {
  Movie({
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
  });

  final String backdropPath;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;

  Movie copyWith({
    String? backdropPath,
    int? id,
    String? originalTitle,
    String? overview,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
  }) =>
      Movie(
        backdropPath: backdropPath ?? this.backdropPath,
        id: id ?? this.id,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
      );

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
      };
}
