class MovieModel {
  final int id;
  final String title;
  final String thumb;
  final String backdrop_path;

  MovieModel({
    required this.id,
    required this.title,
    required this.thumb,
    required this.backdrop_path,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      thumb: "https://image.tmdb.org/t/p/w500${json['poster_path']}",
      backdrop_path: "https://image.tmdb.org/t/p/w500${json['backdrop_path']}",
    );
  }
}
