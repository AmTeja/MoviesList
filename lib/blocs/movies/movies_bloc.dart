import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/models/moviedb_response.dart';
import 'package:movies_list/repository/movie_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository _movieRepository;
  StreamSubscription<List<Movie>>? _moviesSubscription;

  MoviesBloc({required MovieRepository movieRepository})
      : _movieRepository = movieRepository,
        super(MoviesLoading()) {
    on<LoadMovies>(_loadMovies);
    on<UpdateMovies>(_updateMovies);
  }

  void _loadMovies(LoadMovies event, Emitter<MoviesState> emit) {
    _moviesSubscription?.cancel();
    _moviesSubscription = Stream.fromFuture(_movieRepository.fetchMovies())
        .listen((List<Movie> movies) => add(UpdateMovies(movies)));
  }

  void _updateMovies(UpdateMovies event, Emitter<MoviesState> emit) =>
      emit(MoviesLoaded(movies: event.movies));

  @override
  Future<void> close() {
    _moviesSubscription?.cancel();
    return super.close();
  }
}
