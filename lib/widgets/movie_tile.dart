import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/constants.dart';
import 'package:movies_list/models/moviedb_response.dart';
import 'package:movies_list/views/movie_view.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => MovieView(movie: movie))),
      child: Hero(
        tag: movie.id,
        child: Material(
          child: CachedNetworkImage(
              imageUrl: (BASE_IMAGE_URL + movie.backdropPath),
              progressIndicatorBuilder: (context, url, progress) => Container(
                    height: 240,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 240,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider),
                      borderRadius: BorderRadius.circular(13)),
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Container(
                    height: 130,
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(13)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0, 0.6],
                          colors: [Colors.black, Colors.transparent],
                        )),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
