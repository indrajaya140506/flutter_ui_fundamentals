import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tahap10_course_provider.dart';

class Tahap10RepositoryPage extends StatelessWidget {
  const Tahap10RepositoryPage({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    int id,
    String title,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Course?'),
          content: Text(
            'Apakah kamu yakin ingin menghapus course "$title"? '
            'Tindakan ini tidak dapat dibatalkan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await context.read<Tahap10CourseProvider>().deleteCourse(id);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Course berhasil dihapus.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus course: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Tahap10CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 11 - Async State'),
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
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (provider.error != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Gagal memuat data:\n${provider.error}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          context.read<Tahap10CourseProvider>().loadCourses();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              )
            else if (provider.courses.isEmpty)
              const Expanded(
                child: Center(child: Text('Belum ada data course.')),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.courses.length,
                  itemBuilder: (context, index) {
                    final course = provider.courses[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.book)),
                        title: Text(course.title),
                        subtitle: Text(
                          '${course.code} • '
                          '${course.credits} SKS • '
                          '${course.status}',
                        ),
                        trailing: IconButton(
                          tooltip: 'Hapus course',
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                          onPressed: provider.isDeleting || course.id == null
                              ? null
                              : () {
                                  _confirmDelete(
                                    context,
                                    course.id!,
                                    course.title,
                                  );
                                },
                        ),
                      ),
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
