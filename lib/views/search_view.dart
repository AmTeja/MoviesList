import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/cubits/cubit/movie_search_cubit.dart';
import 'package:movies_list/models/moviedb_response.dart';
import 'package:movies_list/repository/movie_search_repository.dart';
import 'package:movies_list/widgets/movie_tile.dart';

class SearchMovieScreen extends StatelessWidget {
  const SearchMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieSearchCubit(context.read<MovieSearchRepository>()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<MovieSearchCubit, MovieSearchState>(
                buildWhen: (previous, current) => previous.query != current.query,
                builder: (context, state) {
                  return TextField(
                      onChanged: ((value) =>
                          context.read<MovieSearchCubit>().queryChanged(value)),
                      onSubmitted: ((value) =>
                          context.read<MovieSearchCubit>().searchSubmitted()),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            /* Clear the search field */
                          },
                        ),
                        hintText: 'Search...',
                      ));
                }),
          ),
          body: BlocBuilder<MovieSearchCubit, MovieSearchState>(
            builder: ((context, state) {
              if (state.searchStatus == SearchStatus.initial) {
                return Container();
              }
              if (state.searchStatus == SearchStatus.submitting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.searchStatus == SearchStatus.error) {
                return Container(
                  child: Text("Error"),
                );
              }
              if (state.searchStatus == SearchStatus.success) {
                List<Movie> movies = state.movies;
                return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: ((context, index) =>
                        MovieTile(movie: movies[index])));
              }
              return Expanded(
                child: Container(
                  color: Colors.red,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
