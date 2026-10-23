import 'package:flutter/material.dart';
import 'models/course.dart';
import 'services/course_service.dart';

class Tahap9ServicePage extends StatefulWidget {
  const Tahap9ServicePage({super.key});

  @override
  State<Tahap9ServicePage> createState() => _Tahap9ServicePageState();
}

class _Tahap9ServicePageState extends State<Tahap9ServicePage> {
  final CourseService _service = CourseService();

  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _service.loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 9 - Course Service'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Komang Indrajaya Darmawiguna',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('NIM: 2455011001'),
            const SizedBox(height: 16),
            const Text(
              'Data Course dari JSON Asset',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: _coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Gagal memuat data: ${snapshot.error}'),
                    );
                  }

                  final courses = snapshot.data ?? [];

                  if (courses.isEmpty) {
                    return const Center(child: Text('Belum ada data course.'));
                  }

                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.book),
                          title: Text(course.title),
                          subtitle: Text(
                            '${course.code} • '
                            '${course.credits} SKS • '
                            '${course.status}',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
