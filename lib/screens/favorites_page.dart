import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../widgets/course_card.dart';
import 'home_page.dart';
import 'course_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseState>(
      builder: (context, favoriteState, child) {
        final favoriteCourses = courses.where((course) {
          return favoriteState.isFavorite(course['code'].toString());
        }).toList();

        if (favoriteCourses.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                SizedBox(height: 12),
                Text(
                  'Belum ada course favorit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            const Text(
              'Favorite Courses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...favoriteCourses.map((course) {
              final code = course['code'].toString();

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CourseCard(
                  course: course,
                  isFavorite: true,
                  onFavorite: () {
                    favoriteState.toggleFavorite(code);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailPage(course: course),
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
  }
}
