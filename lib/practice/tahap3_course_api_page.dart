import 'package:flutter/material.dart';

import '../models/course.dart';
import '../services/course_api_service.dart';
import '../widgets/student_identity_card.dart';

class Tahap3CourseApiPage extends StatefulWidget {
  const Tahap3CourseApiPage({super.key});

  @override
  State<Tahap3CourseApiPage> createState() => _Tahap3CourseApiPageState();
}

class _Tahap3CourseApiPageState extends State<Tahap3CourseApiPage> {
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = CourseApiService().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F46E5);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Tahap 3 - API Courses'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cloud_off_outlined,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text('Gagal memuat data API'),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _coursesFuture = _coursesFuture = CourseApiService()
                              .getCourses();
                        });
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final courses = snapshot.data ?? [];

          if (courses.isEmpty) {
            return const Center(child: Text('Belum ada data course.'));
          }

          final displayedCourses = courses.take(3).toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const StudentIdentityCard(),
              const SizedBox(height: 24),
              const Text(
                'Data Course dari REST API',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Menampilkan ${displayedCourses.length} course '
                'dari ${courses.length} data yang diterima.',
                style: const TextStyle(color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 18),
              ...displayedCourses.map((course) {
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                course.code,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                course.status,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF166534),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'TITLE',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              const Text(
                'Source: JSONPlaceholder REST API',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          );
        },
      ),
    );
  }
}
