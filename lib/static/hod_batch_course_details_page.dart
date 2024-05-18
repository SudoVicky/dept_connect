import 'package:dept_connect/presentation/components/course_detials_tile.dart';
import 'package:flutter/material.dart';

class HodBatchCourseDetailsPage extends StatelessWidget {
  const HodBatchCourseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CourseDetailsTile(
            title: "Course name",
            content: "19CS51 - Unix Internals",
          ),
          CourseDetailsTile(
            title: "Details",
            content:
                "Sec - 1\nS Priya, Assistant Professor\npriya.s@cit.edu.in\nSec - 2\nR pavithra, Assistant Professor\npavithra.r@cit.edu.in",
          ),
          CourseDetailsTile(
            title: "Credit",
            content: "4",
          ),
        ],
      ),
    );
  }
}
