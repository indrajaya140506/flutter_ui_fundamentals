import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentNim = '2455011001';

class Tahap3LiftingStateUpPage extends StatefulWidget {
  const Tahap3LiftingStateUpPage({super.key});

  @override
  State<Tahap3LiftingStateUpPage> createState() =>
      _Tahap3LiftingStateUpPageState();
}

class _Tahap3LiftingStateUpPageState extends State<Tahap3LiftingStateUpPage> {
  // Parent menjadi satu-satunya pemilik state favorit.
  final Set<String> favorites = {};

  final List<String> courses = [
    'Dart Fundamentals',
    'Flutter UI Fundamentals',
    'Responsive Layout',
  ];

  void toggleFavorite(String course) {
    setState(() {
      if (favorites.contains(course)) {
        favorites.remove(course);
      } else {
        favorites.add(course);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 3 - Lifting State Up')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text(studentName),
              subtitle: const Text('NIM: $studentNim'),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Daftar Kursus',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Child pertama menerima state dan callback dari parent.
          CourseListPanel(
            courses: courses,
            favorites: favorites,
            onFavoriteChanged: toggleFavorite,
          ),

          const SizedBox(height: 24),

          // Child kedua menerima state yang sama dari parent.
          FavoriteSummaryPanel(
            favorites: favorites,
            onFavoriteChanged: toggleFavorite,
          ),
        ],
      ),
    );
  }
}

class CourseListPanel extends StatelessWidget {
  final List<String> courses;
  final Set<String> favorites;
  final ValueChanged<String> onFavoriteChanged;

  const CourseListPanel({
    super.key,
    required this.courses,
    required this.favorites,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: courses.map((course) {
        return SharedCourseCard(
          course: course,
          isFavorite: favorites.contains(course),
          onFavoriteChanged: () => onFavoriteChanged(course),
        );
      }).toList(),
    );
  }
}

class SharedCourseCard extends StatelessWidget {
  final String course;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const SharedCourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.menu_book),
        title: Text(course),
        trailing: IconButton(
          tooltip: isFavorite ? 'Hapus favorit' : 'Tambah favorit',
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: onFavoriteChanged,
        ),
      ),
    );
  }
}

class FavoriteSummaryPanel extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onFavoriteChanged;

  const FavoriteSummaryPanel({
    super.key,
    required this.favorites,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kursus Favorit (${favorites.length})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (favorites.isEmpty)
              const Text('Belum ada kursus favorit.')
            else
              ...favorites.map(
                (course) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(course),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Hapus favorit',
                    onPressed: () => onFavoriteChanged(course),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
