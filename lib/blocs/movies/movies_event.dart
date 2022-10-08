part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadMovies extends MoviesEvent {}

class UpdateMovies extends MoviesEvent {
  final List<Movie> movies;

  const UpdateMovies(this.movies);

  @override
  List<Object> get props => [movies];
}
