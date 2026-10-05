import 'package:flutter/material.dart';

import '../widgets/student_identity_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';

final List<Map<String, dynamic>> courses = [
  {
    'code': 'MOB01',
    'title': 'Git & GitHub',
    'category': 'Version Control',
    'status': 'Done',
    'credits': 3,
  },
  {
    'code': 'MOB02',
    'title': 'Dart Fundamentals',
    'category': 'Programming',
    'status': 'Done',
    'credits': 3,
  },
  {
    'code': 'MOB03',
    'title': 'Flutter UI Fundamentals',
    'category': 'UI Development',
    'status': 'Active',
    'credits': 3,
  },
  {
    'code': 'MOB04',
    'title': 'Navigation',
    'category': 'Application Flow',
    'status': 'Planned',
    'credits': 3,
  },
  {
    'code': 'MOB05',
    'title': 'Responsive Layout',
    'category': 'UI Development',
    'status': 'Active',
    'credits': 3,
  },
  {
    'code': 'MOB06',
    'title': 'State Management',
    'category': 'Flutter',
    'status': 'Planned',
    'credits': 3,
  },
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StudentIdentityCard(),

          const SizedBox(height: 20),

          const Text(
            'Welcome to Course Explorer',
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
                  value: '6',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.check_circle,
                  title: 'Completed',
                  value: '2',
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

          CourseCard(
            course: courses[2],
            isFavorite: false,
            onFavorite: () {},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CourseDetailPage(course: courses[2]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
