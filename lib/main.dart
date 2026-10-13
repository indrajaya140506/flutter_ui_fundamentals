import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/course_service.dart';
import 'repositories/course_repository.dart';
import 'providers/tahap10_course_provider.dart';
import 'tahap10_repository.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          Tahap10CourseProvider(CourseRepository(CourseService()))
            ..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tahap10RepositoryPage(),
    );
  }
}
