import 'package:flutter/material.dart';
import 'package:movie_app/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final String title, thumb, section;
  final int id;
  final double width;

  const Movie({
    super.key,
    required this.title,
    required this.id,
    required this.thumb,
    required this.section,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              id: id,
              thumb: thumb,
              section: section,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: '$section-$id', // 섹션+ID로 유니크
            child: Container(
              width: width,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    offset: Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
        ],
      ),
    );
  }
}
