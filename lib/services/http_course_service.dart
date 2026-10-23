import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class HttpCourseService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    debugPrint('HTTP Status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    final courses = data.map((item) {
      final post = item as Map<String, dynamic>;

      // Memetakan JSONPlaceholder ke model Course.
      return Course(
        id: post['id'] as int?,
        code: 'POST-${post['id']}',
        title: post['title'] as String? ?? '',
        credits: 0,
        status: 'planned',
        category: 'API Practice',
      );
    }).toList();

    debugPrint('Jumlah data berhasil diambil: ${courses.length}');

    return courses;
  }
}
