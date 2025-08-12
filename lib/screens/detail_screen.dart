import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, section;
  final int id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.id,
    required this.thumb,
    required this.section,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 앱바 배경 투명
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로가기 동작
          },
        ),
        title: Text(
          "Back to list",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),

      extendBodyBehindAppBar: true, // 바디를 앱바 뒤까지 확장

      body: Stack(
        children: [
          // 배경 이미지
          Hero(
            tag: '${widget.section}-${widget.id}',
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.thumb,
                    fit: BoxFit.cover, // 이미지 확대해서 가득 채우기
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3), // 어둡게 반투명 오버레이
                  ),
                ),
              ],
            ),
          ),

          // 배경 위에 텍스트
          Column(
            children: [
              SizedBox(height: 250),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30), // 좌우 여백 주기
                child: FutureBuilder<MovieDetailModel>(
                  future: movie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 장르 출력
                          PrintGenre(genres: snapshot.data!.genres),
                          // 영화 제목 출력
                          Text(
                            snapshot.data!.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          // 별점 출력
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 30),
                              Text(
                                snapshot.data!.voteAverage.toStringAsFixed(1),

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.7),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "  (${snapshot.data!.voteCount.toString()})",

                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.7),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // 스토리 출력
                          Text(
                            "Storyline",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            height: 180,
                            child: SingleChildScrollView(
                              child: Text(
                                "${snapshot.data!.about}",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.7),
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                softWrap: true,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          // 버튼
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Text(
                              "Buy Ticket",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text("fail to load movie");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PrintGenre extends StatelessWidget {
  final List genres;

  const PrintGenre({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Text(
      genres.map((g) => g.name).join('/ '),
      style: TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 15,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.7),
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
