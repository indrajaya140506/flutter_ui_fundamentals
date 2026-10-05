import 'package:flutter/material.dart';

import '../widgets/student_identity_card.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentIdentityCard(),

            const SizedBox(height: 24),

            Center(
              child: CircleAvatar(
                radius: 42,
                child: Text(
                  course['code'].toString().substring(3),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              course['code'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              course['title'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text('Category: ${course['category']}'),

            const SizedBox(height: 8),

            Text('Status: ${course['status']}'),

            const SizedBox(height: 8),

            Text('Credits: ${course['credits']} SKS'),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Course berhasil dibuka')),
                  );
                },
                child: const Text('Mulai Belajar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
