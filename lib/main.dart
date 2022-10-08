import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/blocs/movies/movies_bloc.dart';
import 'package:movies_list/repository/movie_repository.dart';
import 'package:movies_list/repository/movie_search_repository.dart';
import 'package:movies_list/views/list_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MovieRepository movieRepository = MovieRepository();
  final MovieSearchRepository movieSearchRepository = MovieSearchRepository();
  return runApp(MyApp(
    movieRepository: movieRepository,
    movieSearchRepository: movieSearchRepository,
  ));
}

class MyApp extends StatelessWidget {
  final MovieRepository _movieRepository;
  final MovieSearchRepository _movieSearchRepository;

  const MyApp(
      {required MovieRepository movieRepository,
      super.key,
      required MovieSearchRepository movieSearchRepository})
      : _movieRepository = movieRepository,
        _movieSearchRepository = movieSearchRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: _movieSearchRepository)],
      child: MaterialApp(
        title: 'Movies List',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: BlocProvider(
          create: (_) =>
              MoviesBloc(movieRepository: _movieRepository)..add(LoadMovies()),
          child: ListScreen(),
        ),
      ),
    );
  }
}
