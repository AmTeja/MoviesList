import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/constants.dart';
import 'package:movies_list/models/moviedb_response.dart';

class MovieView extends StatelessWidget {
  final Movie movie;
  const MovieView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Hero(tag: movie.title, child: Text(movie.title)),
      ),
      extendBodyBehindAppBar: true,
      body: Column(children: [
        Expanded(
          flex: 7,
          child: Hero(
            tag: movie.id,
            child: Material(
              child: CachedNetworkImage(
                imageUrl: (BASE_IMAGE_URL + movie.backdropPath),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            children: [
              const Text(
                "Overview",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 28.0,
              ),
              Text(
                movie.overview,
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
              )
            ],
          ),
        )
      ]),
    );
  }
}
