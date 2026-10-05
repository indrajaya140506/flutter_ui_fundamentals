import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap8CourseListPage extends StatelessWidget {
  const Tahap8CourseListPage({super.key});

  final List<Map<String, dynamic>> courses = const [
    {'code': 'MOB01', 'title': 'Git & GitHub', 'credits': 3, 'status': 'Done'},
    {
      'code': 'MOB02',
      'title': 'Dart Fundamentals',
      'credits': 3,
      'status': 'Done',
    },
    {
      'code': 'MOB03',
      'title': 'Flutter UI Fundamentals',
      'credits': 3,
      'status': 'Active',
    },
    {'code': 'MOB04', 'title': 'Navigation', 'credits': 3, 'status': 'Planned'},
    {
      'code': 'MOB05',
      'title': 'Responsive Layout',
      'credits': 3,
      'status': 'Active',
    },
  ];

  void openDetail(BuildContext context, Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 8 - Course List')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
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
                Text(studentId),
                const SizedBox(height: 16),
                const Text(
                  'Daftar Course',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(course['code'].toString().substring(3)),
                    ),
                    title: Text(
                      course['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${course['code']} • ${course['credits']} SKS • ${course['status']}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      openDetail(context, course);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                child: Text(
                  course['code'].toString().substring(3),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Student',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(studentName),

            const SizedBox(height: 4),

            Text(studentId),

            const SizedBox(height: 30),

            const Text(
              'Course Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _DetailItem(
              label: 'Course Code',
              value: course['code'].toString(),
              icon: Icons.code,
            ),

            _DetailItem(
              label: 'Title',
              value: course['title'].toString(),
              icon: Icons.menu_book,
            ),

            _DetailItem(
              label: 'Credits',
              value: '${course['credits']} SKS',
              icon: Icons.school,
            ),

            _DetailItem(
              label: 'Status',
              value: course['status'].toString(),
              icon: Icons.check_circle_outline,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Course List'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
