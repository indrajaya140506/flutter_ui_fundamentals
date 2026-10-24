import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../providers/tahap10_course_provider.dart';
import '../widgets/student_identity_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/course_card.dart';
import 'course_detail_page.dart';
import 'add_course_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color textColor = Color(0xFF0F172A);
  static const Color mutedColor = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Consumer<Tahap10CourseProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                strokeWidth: 3,
              ),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.cloud_off_rounded,
                        size: 36,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Oops! Terjadi Kesalahan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Course belum berhasil dimuat. '
                      'Silakan periksa koneksi dan coba kembali.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: mutedColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: provider.loadCourses,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
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

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Student identity
                          const StudentIdentityCard(),

                          const SizedBox(height: 32),

                          // Welcome section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(26),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF312E81),
                                  Color(0xFF4F46E5),
                                  Color(0xFF6366F1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.16),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: -8,
                                  top: -12,
                                  child: Icon(
                                    Icons.auto_stories_rounded,
                                    size: 112,
                                    color: Colors.white.withValues(alpha: 0.09),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.18,
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.waving_hand_rounded,
                                            color: Color(0xFFFDE68A),
                                            size: 16,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'WELCOME BACK',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 22),
                                    const Text(
                                      'Welcome to\nCourse Data Manager',
                                      style: TextStyle(
                                        fontSize: 30,
                                        height: 1.2,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        letterSpacing: -0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Komang Indrajaya Darmawiguna',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withValues(
                                          alpha: 0.95,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Jelajahi materi Flutter, tingkatkan '
                                      'kemampuanmu, dan pantau progres '
                                      'belajarmu dalam satu tempat.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.7,
                                        color: Colors.white.withValues(
                                          alpha: 0.82,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.verified_rounded,
                                          size: 17,
                                          color: Color(0xFFA5F3FC),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Your learning journey starts here',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.95,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Section heading
                          const Text(
                            'Learning Overview',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Ringkasan perjalanan belajarmu saat ini.',
                            style: TextStyle(
                              fontSize: 13,
                              color: mutedColor,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const AddCoursePage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Tambah Course'),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Summary cards

                          // Summary cards
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isWide = constraints.maxWidth >= 560;

                              final cards = [
                                SummaryCard(
                                  icon: Icons.menu_book_rounded,
                                  title: 'Courses',
                                  value: '${courses.length}',
                                ),
                                SummaryCard(
                                  icon: Icons.task_alt_rounded,
                                  title: 'Completed',
                                  value: '$completed',
                                ),
                              ];

                              if (isWide) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: cards[0]),
                                    const SizedBox(width: 16),
                                    Expanded(child: cards[1]),
                                  ],
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  cards[0],
                                  const SizedBox(height: 14),
                                  cards[1],
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 32),

                          // Current learning heading
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.play_lesson_rounded,
                                  color: primaryColor,
                                  size: 23,
                                ),
                              ),
                              const SizedBox(width: 13),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Current Learning',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: textColor,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lanjutkan course pilihanmu.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: mutedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  '${courses.length} courses',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Current course
                          if (course == null)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 36,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.library_books_outlined,
                                    size: 48,
                                    color: Color(0xFF94A3B8),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Belum Ada Course',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Course yang tersedia akan muncul '
                                    'di bagian ini.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.6,
                                      color: mutedColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
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
                                    builder: (_) => CourseDetailPage(
                                      course: course.toMap(),
                                    ),
                                  ),
                                );
                              },
                            ),

                          const SizedBox(height: 28),

                          // Footer
                          Center(
                            child: Text(
                              'COURSE DATA MANAGER   •  KEEP LEARNING, KEEP GROWING',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                color: Colors.blueGrey.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
