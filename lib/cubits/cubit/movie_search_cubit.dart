import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/repository/movie_search_repository.dart';

import '../../models/moviedb_response.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final MovieSearchRepository _movieSearchRepository;

  MovieSearchCubit(this._movieSearchRepository)
      : super(MovieSearchState.initial());

  void queryChanged(String value) {
    emit(state.copyWith(query: value, searchStatus: SearchStatus.initial));
    searchSubmitted();
  }

  Future<void> searchSubmitted() async {
    emit(state.copyWith(searchStatus: SearchStatus.submitting));
    try {
      List<Movie> movies =
          await _movieSearchRepository.searchMovies(query: state.query);
      emit(state.copyWith(searchStatus: SearchStatus.success, movies: movies));
      for (Movie movie in movies) {
        print(movie.title);
      }
      print("Completed");
    } catch (_) {}
  }
}
