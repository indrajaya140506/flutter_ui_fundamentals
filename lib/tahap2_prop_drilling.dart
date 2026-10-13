import 'package:flutter/material.dart';

class Tahap2PropDrillingPage extends StatefulWidget {
  const Tahap2PropDrillingPage({super.key});

  @override
  State<Tahap2PropDrillingPage> createState() => _Tahap2PropDrillingPageState();
}

class _Tahap2PropDrillingPageState extends State<Tahap2PropDrillingPage> {
  // Satu sumber state pada parent.
  final Set<String> favorites = {};

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
    const courses = [
      'Dart Fundamentals',
      'Flutter UI Fundamentals',
      'Responsive Layout',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 2 - Prop Drilling')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Course List', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),

          // Child 1: menerima data dan callback dari parent.
          CourseListChild(
            courses: courses,
            favorites: favorites,
            onFavoriteToggle: toggleFavorite,
          ),

          const Divider(height: 32),

          // Child 2: menerima state dan callback yang sama.
          FavoritePanelChild(
            favorites: favorites,
            onFavoriteToggle: toggleFavorite,
          ),
        ],
      ),
    );
  }
}

class CourseListChild extends StatelessWidget {
  final List<String> courses;
  final Set<String> favorites;
  final ValueChanged<String> onFavoriteToggle;

  const CourseListChild({
    super.key,
    required this.courses,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: courses.map((course) {
        final isFavorite = favorites.contains(course);

        return ListTile(
          title: Text(course),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () => onFavoriteToggle(course),
          ),
        );
      }).toList(),
    );
  }
}

class FavoritePanelChild extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onFavoriteToggle;

  const FavoritePanelChild({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kursus Favorit (${favorites.length})',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        if (favorites.isEmpty)
          const Text('Belum ada kursus favorit.')
        else
          ...favorites.map(
            (course) => ListTile(
              title: Text(course),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => onFavoriteToggle(course),
              ),
            ),
          ),
      ],
    );
  }
}
