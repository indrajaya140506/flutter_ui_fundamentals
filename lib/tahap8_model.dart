import 'package:flutter/material.dart';
import 'models/course.dart';

class Tahap8ModelPage extends StatelessWidget {
  const Tahap8ModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Map<String, dynamic> courseJson = {
      'code': 'TRPL008',
      'title': 'Pemrograman Aplikasi Mobile',
      'credits': 3,
      'status': 'Aktif',
    };

    final course = Course.fromJson(courseJson);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 8 - Model Course'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Komang Indrajaya Darmawiguna',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('NIM: 2455011001'),
            const SizedBox(height: 24),
            const Text(
              'Detail Course',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Kode Course'),
              subtitle: Text(course.code),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Nama Course'),
              subtitle: Text(course.title),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Jumlah SKS'),
              subtitle: Text('${course.credits} SKS'),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Status'),
              subtitle: Text(course.status),
            ),
          ],
        ),
      ),
    );
  }
}
