import 'package:flutter/material.dart';

import '../widgets/student_identity_card.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';
import 'home_page.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final Set<String> favorites = {};

  void toggleFavorite(String code) {
    setState(() {
      if (favorites.contains(code)) {
        favorites.remove(code);
      } else {
        favorites.add(code);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          favorites.contains(code)
              ? 'Course ditambahkan ke Favorite'
              : 'Course dihapus dari Favorite',
        ),
      ),
    );
  }

  void openCourse(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
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

              ...courses.map(
                (course) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CourseCard(
                    course: course,
                    isFavorite: favorites.contains(course['code']),
                    onFavorite: () {
                      toggleFavorite(course['code']);
                    },
                    onTap: () {
                      openCourse(course);
                    },
                  ),
                ),
              ),
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

            return CourseCard(
              course: course,
              isFavorite: favorites.contains(course['code']),
              onFavorite: () {
                toggleFavorite(course['code']);
              },
              onTap: () {
                openCourse(course);
              },
            );
          },
        );
      },
    );
  }
}
