class Genre {
  final int id;
  final String name;

  Genre.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'];
}

class MovieDetailModel {
  final String title;
  final String about;
  final List<Genre> genres;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      about = json['overview'],
      genres = (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      voteAverage = (json['vote_average'] as num).toDouble(),
      voteCount = json['vote_count'];
}
