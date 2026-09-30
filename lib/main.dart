import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

// ============================================================
// LOAD JSON
// ============================================================

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );

  return jsonDecode(jsonString) as Map<String, dynamic>;
}

// ============================================================
// SUMMARY CARD - REUSABLE WIDGET 1
// ============================================================

class SummaryCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black87),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COURSE CARD - REUSABLE WIDGET 2
// ============================================================

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final String status = course['status'] as String;

    IconData statusIcon;
    String statusText;

    if (status == 'done') {
      statusIcon = Icons.check_circle;
      statusText = 'Selesai';
    } else if (status == 'active') {
      statusIcon = Icons.play_circle_fill;
      statusText = 'Aktif';
    } else {
      statusIcon = Icons.schedule;
      statusText = 'Rencana';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course code
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              course['code'].toString().replaceAll('MOB', ''),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Course information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  course['category'] as String,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 15,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${course['credits']} SKS',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Icon(statusIcon, size: 15, color: Colors.black87),
                    const SizedBox(width: 5),
                    Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MAIN APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F7F7),
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

// ============================================================
// DASHBOARD PAGE
// ============================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();

    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Learning Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,

        builder: (context, snapshot) {
          // =========================
          // LOADING STATE
          // =========================

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // =========================
          // ERROR STATE
          // =========================

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),

                    const SizedBox(height: 12),

                    const Text(
                      'Gagal memuat data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text('${snapshot.error}', textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }

          // =========================
          // DATA
          // =========================

          final data = snapshot.data!;

          final student = data['student'] as Map<String, dynamic>;

          final courses = data['courses'] as List<dynamic>;

          final int totalCourses = courses.length;

          final int totalCredits = courses.fold<int>(
            0,
            (total, item) => total + (item['credits'] as int),
          );

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),

              children: [
                // ==================================================
                // PROFILE
                // ==================================================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 34,
                        backgroundImage: AssetImage(
                          'assets/images/profile.jpg',
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              student['name'] as String,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              student['nim'] as String,

                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Mobile Programming Student',

                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ==================================================
                // FLUTTER UI FUNDAMENTALS
                // ==================================================
                Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // Judul
                      const Text(
                        'Flutter UI Fundamentals',

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Pertemuan
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Bulatan profile/icon
                          Container(
                            width: 48,
                            height: 48,

                            decoration: BoxDecoration(
                              color: Colors.black87,
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.flutter_dash,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Informasi pembelajaran
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  'Pertemuan 4',

                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Text(
                                      'Topik',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),

                                    const Spacer(),

                                    const Text(
                                      '10',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Text(
                                      'Progres',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),

                                    const Spacer(),

                                    const Text(
                                      '75%',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Progress bar
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),

                                  child: LinearProgressIndicator(
                                    value: 0.75,
                                    minHeight: 7,
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Colors.black87,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ==================================================
                // SUMMARY
                // ==================================================
                const Text(
                  'Learning Summary',

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    SummaryCard(
                      value: '$totalCourses',
                      label: 'Total Course',
                      icon: Icons.menu_book_outlined,
                    ),

                    const SizedBox(width: 12),

                    SummaryCard(
                      value: '$totalCredits',
                      label: 'Total SKS',
                      icon: Icons.school_outlined,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ==================================================
                // COURSE LIST
                // ==================================================
                const Text(
                  'My Courses',

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                ...courses.map(
                  (course) =>
                      CourseCard(course: course as Map<String, dynamic>),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
