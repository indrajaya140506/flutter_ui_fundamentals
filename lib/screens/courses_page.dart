import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../course_state.dart';
import '../providers/tahap10_course_provider.dart';
import '../widgets/student_identity_card.dart';
import '../widgets/course_card.dart';
import '../widgets/error_view.dart';
import 'course_detail_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  Future<void> _deleteCourse(
    BuildContext context,
    Tahap10CourseProvider provider,
    CourseState favoriteState,
    int id,
    String code,
    String title,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Course?'),
        content: Text('Yakin ingin menghapus "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await provider.deleteCourse(id);

      if (!context.mounted) return;

      // Hapus dari Favorites jika masih menjadi favorit.
      if (favoriteState.isFavorite(code)) {
        favoriteState.toggleFavorite(code);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course "$title" berhasil dihapus.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus course: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Tahap10CourseProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return ErrorView(
            message: provider.error!,
            onRetry: provider.loadCourses,
          );
        }

        if (provider.courses.isEmpty) {
          return const Center(child: Text('Data course belum tersedia'));
        }

        return Consumer<CourseState>(
          builder: (context, favoriteState, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 840;

                Widget buildCourseItem(int index) {
                  final course = provider.courses[index];
                  final data = course.toMap();

                  return Column(
                    children: [
                      CourseCard(
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
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          tooltip: 'Delete Course',
                          onPressed: provider.isDeleting || course.id == null
                              ? null
                              : () => _deleteCourse(
                                  context,
                                  provider,
                                  favoriteState,
                                  course.id!,
                                  course.code,
                                  course.title,
                                ),
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                }

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
                      ...List.generate(
                        provider.courses.length,
                        buildCourseItem,
                      ),
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
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return buildCourseItem(index);
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
