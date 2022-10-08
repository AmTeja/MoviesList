import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/blocs/movies/movies_bloc.dart';
import 'package:movies_list/models/moviedb_response.dart';
import 'package:movies_list/views/search_view.dart';
import 'package:movies_list/widgets/movie_tile.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Watch",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const SearchMovieScreen())),
                icon: const Hero(
                  tag: 'search',
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: ((context, state) {
            if (state is MoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MoviesLoaded) {
              List<Movie> movies = state.movies;
              return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: ((context, index) =>
                      MovieTile(movie: movies[index])));
            }
            return const Center(
              child: Text("Some unknown error occured"),
            );
          }),
        ));
  }
}
