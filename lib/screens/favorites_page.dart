import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../providers/tahap10_course_provider.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Tahap10CourseProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Data course gagal dimuat.'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: provider.loadCourses,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        return Consumer<CourseState>(
          builder: (context, favoriteState, child) {
            final favorites = provider.courses
                .where((course) => favoriteState.isFavorite(course.code))
                .toList();

            if (favorites.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada course favorit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Tambahkan course dari halaman Courses.'),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Favorite Courses (${favorites.length})',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...favorites.map((course) {
                  final data = course.toMap();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CourseCard(
                      course: data,
                      isFavorite: true,
                      onFavorite: () {
                        favoriteState.toggleFavorite(course.code);
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseDetailPage(course: data),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }
}
