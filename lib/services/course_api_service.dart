import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Course>> getCourses() async {
    final response = await _client.get(Uri.parse('$baseUrl/posts'));

    debugPrint('HTTP Status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course: HTTP ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    final courses = data.map((item) {
      final post = item as Map<String, dynamic>;

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

  void dispose() {
    _client.close();
  }
}
