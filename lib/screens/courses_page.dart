import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../providers/tahap10_course_provider.dart';
import '../widgets/student_identity_card.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Tahap10CourseProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  const Text('Gagal memuat data course'),
                  const SizedBox(height: 8),
                  Text(provider.error!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: provider.loadCourses,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        if (provider.courses.isEmpty) {
          return const Center(child: Text('Belum ada data course.'));
        }

        return Consumer<CourseState>(
          builder: (context, favoriteState, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 840;

                final courseCards = provider.courses.map((course) {
                  final data = course.toMap();
                  final code = course.code;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CourseCard(
                      course: data,
                      isFavorite: favoriteState.isFavorite(code),
                      onFavorite: () {
                        favoriteState.toggleFavorite(code);
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
                }).toList();

                if (isMobile) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const StudentIdentityCard(),
                      const SizedBox(height: 20),
                      Text(
                        'All Courses (${provider.courses.length})',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...courseCards,
                    ],
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: provider.courses.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.45,
                  ),
                  itemBuilder: (context, index) {
                    final course = provider.courses[index];
                    final data = course.toMap();

                    return CourseCard(
                      course: data,
                      isFavorite: favoriteState.isFavorite(course.code),
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
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
