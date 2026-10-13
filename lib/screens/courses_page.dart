import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../widgets/student_identity_card.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';
import 'home_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  void openCourse(BuildContext context, Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseState>(
      builder: (context, favoriteState, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 840) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const StudentIdentityCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'All Courses',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...courses.map((course) {
                    final code = course['code'].toString();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CourseCard(
                        course: course,
                        isFavorite: favoriteState.isFavorite(code),
                        onFavorite: () {
                          favoriteState.toggleFavorite(code);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                favoriteState.isFavorite(code)
                                    ? 'Course ditambahkan ke Favorite'
                                    : 'Course dihapus dari Favorite',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        onTap: () => openCourse(context, course),
                      ),
                    );
                  }),
                ],
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.45,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final code = course['code'].toString();

                return CourseCard(
                  course: course,
                  isFavorite: favoriteState.isFavorite(code),
                  onFavorite: () {
                    favoriteState.toggleFavorite(code);
                  },
                  onTap: () => openCourse(context, course),
                );
              },
            );
          },
        );
      },
    );
  }
}
