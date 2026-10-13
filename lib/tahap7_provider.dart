import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Course {
  final String code;
  final String title;
  bool isFavorite;

  Course({required this.code, required this.title, this.isFavorite = false});
}

class CourseProvider extends ChangeNotifier {
  final List<Course> _courses = [
    Course(code: 'CRS001', title: 'Flutter Dasar'),
    Course(code: 'CRS002', title: 'State Management'),
    Course(code: 'CRS003', title: 'UI Design'),
  ];

  List<Course> get courses => _courses;

  int get favoriteCount => _courses.where((course) => course.isFavorite).length;

  void toggleFavorite(String code) {
    final course = _courses.firstWhere((course) => course.code == code);

    course.isFavorite = !course.isFavorite;
    notifyListeners();
  }
}

class Tahap7ProviderPage extends StatelessWidget {
  const Tahap7ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseProvider(),
      child: const CourseFavoritePage(),
    );
  }
}

class CourseFavoritePage extends StatelessWidget {
  const CourseFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 7 - Provider'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Komang Indrajaya Darmawiguna',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('NIM: 2455011001'),
            const SizedBox(height: 16),

            // watch: jumlah favorite diperbarui saat state berubah.
            const FavoriteCount(),

            const SizedBox(height: 12),
            const Text(
              'Daftar Course',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView(
                children: [
                  for (final course in context.read<CourseProvider>().courses)
                    Card(
                      child: ListTile(
                        title: Text(course.title),
                        subtitle: Text('Kode: ${course.code}'),

                        // Consumer membatasi area yang mendengarkan
                        // perubahan favorite pada ikon ini.
                        trailing: Consumer<CourseProvider>(
                          builder: (context, provider, child) {
                            final isFavorite = provider.courses
                                .firstWhere((item) => item.code == course.code)
                                .isFavorite;

                            return IconButton(
                              onPressed: () {
                                // read: memanggil aksi tanpa listen.
                                context.read<CourseProvider>().toggleFavorite(
                                  course.code,
                                );
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              tooltip: 'Toggle favorite',
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCount extends StatelessWidget {
  const FavoriteCount({super.key});

  @override
  Widget build(BuildContext context) {
    // watch: widget ini rebuild saat Provider berubah.
    final provider = context.watch<CourseProvider>();

    return Text(
      'Jumlah Favorite: ${provider.favoriteCount}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
