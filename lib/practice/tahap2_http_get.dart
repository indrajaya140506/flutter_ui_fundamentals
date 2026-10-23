import 'package:flutter/foundation.dart';

import '../services/course_api_service.dart';

Future<void> testHttpGet() async {
  try {
    final courses = await CourseApiService().getCourses();

    debugPrint('GET berhasil. Total course: ${courses.length}');

    for (final course in courses.take(3)) {
      debugPrint('${course.code} | ${course.title} | ${course.status}');
    }
  } catch (error) {
    debugPrint('GET gagal: $error');
  }
}
