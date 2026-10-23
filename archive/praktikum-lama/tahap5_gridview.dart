import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap5GridViewPage extends StatelessWidget {
  const Tahap5GridViewPage({super.key});

  int columnsFor(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final courses = [
      {
        'code': 'MOB01',
        'title': 'Git & GitHub',
        'category': 'Version Control',
        'icon': Icons.code,
      },
      {
        'code': 'MOB02',
        'title': 'Dart Fundamentals',
        'category': 'Programming',
        'icon': Icons.data_object,
      },
      {
        'code': 'MOB03',
        'title': 'Flutter UI Fundamentals',
        'category': 'UI Development',
        'icon': Icons.phone_android,
      },
      {
        'code': 'MOB04',
        'title': 'Navigation',
        'category': 'Application Flow',
        'icon': Icons.navigation,
      },
      {
        'code': 'MOB05',
        'title': 'Responsive Layout',
        'category': 'UI Development',
        'icon': Icons.devices,
      },
      {
        'code': 'MOB06',
        'title': 'State Management',
        'category': 'Flutter',
        'icon': Icons.settings,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 5 - GridView Responsif')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = columnsFor(constraints.maxWidth);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(studentId, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Text(
                  'Course Explorer',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$columns kolom • ${courses.length} course',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];

                      return CourseCard(
                        code: course['code'] as String,
                        title: course['title'] as String,
                        category: course['category'] as String,
                        icon: course['icon'] as IconData,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String code;
  final String title;
  final String category;
  final IconData icon;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.category,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 12),
            Text(
              code,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(category, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
