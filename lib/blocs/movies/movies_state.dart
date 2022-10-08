part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;

  const MoviesLoaded({this.movies = const <Movie>[]});

  @override
  List<Object> get props => [movies];
}
