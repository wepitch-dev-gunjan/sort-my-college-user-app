import 'package:flutter/material.dart';

import 'ep_comp.dart';

class CourseSection extends StatelessWidget {
  final String id;
  final dynamic courses;
  const CourseSection({
    super.key,
    required this.courses, required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Courses Offered",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          UgCourses(data: courses, title: "Undergraduate Courses",id: id,),
          const SizedBox(height: 20.0),
          PgCourses(data: courses, title: "Postgraduate Courses",id: id,),
        ],
      ),
    );
  }
}
