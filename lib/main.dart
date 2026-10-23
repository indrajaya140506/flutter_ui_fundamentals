import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tahap10_course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_api_service.dart';
import 'tahap14_course_explorer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          Tahap10CourseProvider(CourseRepository(CourseApiService()))
            ..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}
