import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Course {
  final String title;
  final String description;
  bool isCompleted;

  Course({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class CourseProvider extends ChangeNotifier {
  final List<Course> _courses = [
    Course(
      title: 'Flutter Dasar',
      description: 'Mempelajari dasar pengembangan aplikasi Flutter.',
    ),
    Course(
      title: 'State Management',
      description: 'Mempelajari pengelolaan state menggunakan Provider.',
    ),
    Course(
      title: 'UI Design',
      description: 'Mempelajari pembuatan antarmuka aplikasi.',
    ),
  ];

  List<Course> get courses => _courses;

  void toggleCourse(int index) {
    _courses[index].isCompleted = !_courses[index].isCompleted;
    notifyListeners();
  }
}

class Tahap6ProviderPage extends StatelessWidget {
  const Tahap6ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseProvider(),
      child: const CourseListPage(),
    );
  }
}

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseProvider>().courses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 6 - Provider'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Daftar Course',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Provider menyediakan state agar dapat diakses '
            'oleh widget di bawahnya.',
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < courses.length; i++)
            Card(
              child: CheckboxListTile(
                title: Text(courses[i].title),
                subtitle: Text(courses[i].description),
                value: courses[i].isCompleted,
                onChanged: (_) {
                  context.read<CourseProvider>().toggleCourse(i);
                },
              ),
            ),
        ],
      ),
    );
  }
}
