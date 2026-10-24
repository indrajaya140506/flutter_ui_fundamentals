import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  CourseApiService({
    http.Client? client,
    this.baseUrl = 'https://jsonplaceholder.typicode.com',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Exception _networkError(Object error) {
    return Exception(
      'Koneksi gagal. Periksa internet dan coba lagi. Detail: $error',
    );
  }

  dynamic _decodeJson(String body) {
    try {
      return jsonDecode(body);
    } on FormatException catch (error) {
      throw FormatException(
        'Respons server bukan JSON yang valid: ${error.message}',
      );
    }
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;

    throw const FormatException(
      'Format data tidak sesuai: respons seharusnya berupa objek JSON.',
    );
  }

  void _checkStatus(http.Response response, String operation) {
    if (response.statusCode == 404) {
      throw Exception(
        '$operation gagal: endpoint tidak ditemukan (HTTP 404). '
        'Periksa URL dan coba lagi.',
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        '$operation gagal: server mengembalikan HTTP '
        '${response.statusCode}.',
      );
    }
  }

  Future<http.Response> _request(
    Future<http.Response> Function() action,
    String operation,
  ) async {
    try {
      final response = await action().timeout(const Duration(seconds: 15));

      debugPrint('$operation Status: ${response.statusCode}');
      _checkStatus(response, operation);

      return response;
    } on TimeoutException {
      throw Exception(
        '$operation melewati batas waktu 15 detik. '
        'Periksa koneksi dan coba lagi.',
      );
    } on http.ClientException catch (error) {
      throw _networkError(error);
    } on FormatException {
      rethrow;
    }
  }

  @override
  Future<List<Course>> getCourses() async {
    final response = await _request(
      () => _client.get(_uri('/posts')),
      'GET courses',
    );

    final data = _decodeJson(response.body);

    if (data is! List) {
      throw const FormatException(
        'Format daftar course tidak valid: respons seharusnya berupa array.',
      );
    }

    return data.map((item) {
      final post = _asMap(item);
      final rawId = post['id'];

      if (rawId is! int) {
        throw const FormatException(
          'Data course tidak valid: id harus berupa integer.',
        );
      }

      final rawTitle = post['title'];

      if (rawTitle is! String) {
        throw const FormatException(
          'Data course tidak valid: title harus berupa teks.',
        );
      }

      return Course(
        id: rawId,
        code: 'POST-$rawId',
        title: rawTitle,
        credits: 0,
        status: 'planned',
        category: 'API Practice',
      );
    }).toList();
  }

  @override
  Future<Course> createCourse(Course course) async {
    final response = await _request(
      () => _client.post(
        _uri('/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(course.toJson()),
      ),
      'POST course',
    );

    final data = _asMap(_decodeJson(response.body));

    return Course(
      id: data['id'] is int ? data['id'] as int : null,
      code: data['code'] is String ? data['code'] as String : course.code,
      title: data['title'] is String ? data['title'] as String : course.title,
      credits: data['credits'] is num
          ? (data['credits'] as num).toInt()
          : course.credits,
      status: data['status'] is String
          ? data['status'] as String
          : course.status,
      category: data['category'] is String
          ? data['category'] as String
          : course.category,
    );
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    await _request(
      () => _client.put(
        _uri('/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(course.toJson()),
      ),
      'PUT course',
    );
  }

  @override
  Future<void> deleteCourse(int id) async {
    await _request(() => _client.delete(_uri('/posts/$id')), 'DELETE course');
  }

  void dispose() {
    _client.close();
  }
}
