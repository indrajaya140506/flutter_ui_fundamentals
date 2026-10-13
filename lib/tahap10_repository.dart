import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tahap10_course_provider.dart';

class Tahap10RepositoryPage extends StatelessWidget {
  const Tahap10RepositoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Tahap10CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 10 - Repository'),
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
              'Daftar Course',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.errorMessage != null)
              Text('Gagal memuat data: ${provider.errorMessage}')
            else if (provider.courses.isEmpty)
              const Text('Belum ada data course.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.courses.length,
                  itemBuilder: (context, index) {
                    final course = provider.courses[index];

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
                ),
              ),
            if (!provider.isLoading && provider.errorMessage != null)
              ElevatedButton(
                onPressed: () {
                  context.read<Tahap10CourseProvider>().loadCourses();
                },
                child: const Text('Coba Lagi'),
              ),
          ],
        ),
      ),
    );
  }
}
