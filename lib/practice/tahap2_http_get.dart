import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Endpoint latihan: mengembalikan daftar post berbentuk JSON array.
const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

/// Mengambil daftar post dari API menggunakan HTTP GET.
Future<List<dynamic>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));

  debugPrint('HTTP Status: ${response.statusCode}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;

    debugPrint('Jumlah item berhasil diambil: ${data.length}');

    return data;
  }

  throw Exception('HTTP ${response.statusCode}');
}

/// Menjalankan pengujian GET secara manual.
Future<void> testHttpGet() async {
  try {
    final courses = await fetchCourses();
    debugPrint('GET berhasil. Total item: ${courses.length}');
  } catch (error) {
    debugPrint('GET gagal: $error');
  }
}
