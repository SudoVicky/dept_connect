import 'package:flutter/material.dart';

class CourseDetailsTile extends StatelessWidget {
  final String title;
  final String content;
  const CourseDetailsTile(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
