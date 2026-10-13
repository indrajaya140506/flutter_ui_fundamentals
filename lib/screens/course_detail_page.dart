import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../widgets/student_identity_card.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final code = course['code'].toString();

    return Consumer<CourseState>(
      builder: (context, favoriteState, child) {
        final isFavorite = favoriteState.isFavorite(code);

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
                      code.length > 3 ? code.substring(3) : code,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course['title'].toString(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Category: ${course['category']}'),
                const SizedBox(height: 8),
                Text('Status: ${course['status']}'),
                const SizedBox(height: 8),
                Text('Credits: ${course['credits']} SKS'),
                const SizedBox(height: 24),

                // Status dan tombol favorite
                Card(
                  child: ListTile(
                    leading: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                      size: 30,
                    ),
                    title: Text(
                      isFavorite ? 'Course Favorit' : 'Belum menjadi Favorit',
                    ),
                    subtitle: Text(
                      isFavorite
                          ? 'Course ini tersimpan di daftar favorit.'
                          : 'Tambahkan course ini ke daftar favorit.',
                    ),
                    trailing: IconButton(
                      tooltip: isFavorite
                          ? 'Hapus dari favorit'
                          : 'Tambah ke favorit',
                      onPressed: () {
                        favoriteState.toggleFavorite(code);
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                    ),
                  ),
                ),

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
      },
    );
  }
}
