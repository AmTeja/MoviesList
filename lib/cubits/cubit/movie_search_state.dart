part of 'movie_search_cubit.dart';

enum SearchStatus { initial, submitting, success, error }

class MovieSearchState extends Equatable {
  final String query;
  final SearchStatus searchStatus;
  final List<Movie> movies;

  const MovieSearchState(
      {required this.searchStatus, required this.query, required this.movies});

  factory MovieSearchState.initial() {
    return const MovieSearchState(
        query: '', searchStatus: SearchStatus.initial, movies: []);
  }

  @override
  List<Object> get props => [query, searchStatus];

  MovieSearchState copyWith({
    String? query,
    SearchStatus? searchStatus,
    List<Movie>? movies,
  }) {
    return MovieSearchState(
        movies: movies ?? this.movies,
        searchStatus: searchStatus ?? this.searchStatus,
        query: query ?? this.query);
  }
}
