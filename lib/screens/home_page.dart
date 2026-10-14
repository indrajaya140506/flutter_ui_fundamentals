import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../providers/tahap10_course_provider.dart';
import '../widgets/student_identity_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  const Text('Gagal memuat course.'),
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

        final courses = provider.courses;
        final completed = courses
            .where((course) => course.status.toLowerCase() == 'done')
            .length;

        final currentCourse = courses
            .where((course) => course.status.toLowerCase() == 'active')
            .firstOrNull;

        return Consumer<CourseState>(
          builder: (context, favoriteState, child) {
            final course =
                currentCourse ?? (courses.isNotEmpty ? courses.first : null);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StudentIdentityCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to Course Explorer v2 Indrajaya  Darmmawiguna',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Jelajahi materi pembelajaran Flutter '
                    'dan lihat perkembangan course kamu.',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.school,
                          title: 'Courses',
                          value: '${courses.length}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.check_circle,
                          title: 'Completed',
                          value: '$completed',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Current Learning',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (course == null)
                    const Text('Belum ada course tersedia.')
                  else
                    CourseCard(
                      course: course.toMap(),
                      isFavorite: favoriteState.isFavorite(course.code),
                      onFavorite: () {
                        favoriteState.toggleFavorite(course.code);
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CourseDetailPage(course: course.toMap()),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
