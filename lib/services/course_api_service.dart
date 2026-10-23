import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  CourseApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET: Mengambil daftar course
  Future<List<Course>> getCourses() async {
    final response = await _client.get(Uri.parse('$baseUrl/posts'));

    debugPrint('GET Status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course: HTTP ${response.statusCode}');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data.map((item) {
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
  }

  // POST: Membuat course baru
  Future<Course> createCourse(Course course) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(course.toJson()),
    );

    debugPrint('POST Status: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return Course(
        id: data['id'] as int?,
        code: data['code'] as String? ?? course.code,
        title: data['title'] as String? ?? course.title,
        credits: (data['credits'] as num?)?.toInt() ?? course.credits,
        status: data['status'] as String? ?? course.status,
        category: data['category'] as String? ?? course.category,
      );
    }

    throw Exception('Gagal membuat course: HTTP ${response.statusCode}');
  }

  void dispose() {
    _client.close();
  }
}
