import 'package:flutter/material.dart';
import 'course_state.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentNim = '2455011001';

class Tahap5ChangeNotifierPage extends StatefulWidget {
  const Tahap5ChangeNotifierPage({super.key});

  @override
  State<Tahap5ChangeNotifierPage> createState() =>
      _Tahap5ChangeNotifierPageState();
}

class _Tahap5ChangeNotifierPageState extends State<Tahap5ChangeNotifierPage> {
  late final CourseState courseState;

  final List<Map<String, String>> courses = const [
    {'id': 'dart', 'name': 'Dart Fundamentals'},
    {'id': 'flutter', 'name': 'Flutter UI Fundamentals'},
    {'id': 'responsive', 'name': 'Responsive Layout'},
  ];

  @override
  void initState() {
    super.initState();
    courseState = CourseState();
  }

  @override
  void dispose() {
    courseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 5 - ChangeNotifier')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(studentName),
              subtitle: Text('NIM: $studentNim'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Daftar Kursus',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Listener pertama: menampilkan daftar kursus dan ikon favorit.
          ListenableBuilder(
            listenable: courseState,
            builder: (context, child) {
              return Column(
                children: courses.map((course) {
                  final id = course['id']!;
                  final name = course['name']!;
                  final isFavorite = courseState.isFavorite(id);

                  return Card(
                    child: ListTile(
                      title: Text(name),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          courseState.toggleFavorite(id);
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),

          // Listener kedua: menampilkan ringkasan state yang sama.
          ListenableBuilder(
            listenable: courseState,
            builder: (context, child) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Total Kursus Favorit'),
                  trailing: Text(
                    '${courseState.favoriteCount}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
