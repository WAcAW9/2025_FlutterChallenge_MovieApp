import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> movies = ApiService.getPopularMovie();
  final Future<List<MovieModel>> commingSoonMovies =
      ApiService.getCommingSoonMovie();
  final Future<List<MovieModel>> nowPlayMovies =
      ApiService.getNowPlayingMovie();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SectionTitle(text: "Popular Movies"),

            SizedBox(
              height: 200,
              child: FutureBuilder<List<MovieModel>>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makeList2(snapshot, 'popular');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),

            SectionTitle(text: "Now in Cinemas"),

            SizedBox(
              height: 250,
              child: FutureBuilder<List<MovieModel>>(
                future: nowPlayMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makeList(snapshot, 'nowPlay');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),

            SectionTitle(text: "Comming Soon"),

            SizedBox(
              height: 280,
              child: FutureBuilder<List<MovieModel>>(
                future: commingSoonMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makeList(snapshot, 'comminSoon');
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot, String section) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: snapshot.data!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return Movie(
          title: movie.title,
          id: movie.id,
          thumb: movie.thumb,
          section: section,
          width: 150,
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 20),
    );
  }

  ListView makeList2(AsyncSnapshot<List<MovieModel>> snapshot, String section) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: snapshot.data!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return Movie(
          title: movie.title,
          id: movie.id,
          thumb: movie.backdrop_path,
          section: section,
          width: 300,
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 20),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
