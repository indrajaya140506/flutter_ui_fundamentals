import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap12InteractionPage extends StatefulWidget {
  const Tahap12InteractionPage({super.key});

  @override
  State<Tahap12InteractionPage> createState() => _Tahap12InteractionPageState();
}

class _Tahap12InteractionPageState extends State<Tahap12InteractionPage> {
  bool isFavorite = false;

  final Map<String, dynamic> course = {
    'code': 'MOB03',
    'title': 'Flutter UI Fundamentals',
    'category': 'UI Development',
    'status': 'Active',
  };

  void showCourseInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Informasi Course'),
          content: Text(
            '${course['code']}\n'
            '${course['title']}\n'
            'Kategori: ${course['category']}\n'
            'Status: ${course['status']}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 12 - User Interaction')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            studentName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            studentId,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          const Text(
            'Course Explorer',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${course['title']} dipilih')),
              );
            },
            onLongPress: showCourseInfo,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      child: Text(course['code'].toString().substring(3)),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['code'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            course['title'],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(course['category']),
                          const SizedBox(height: 4),
                          Text(
                            course['status'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      tooltip: 'Favorite',
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFavorite
                                  ? 'Course ditambahkan ke Favorite'
                                  : 'Course dihapus dari Favorite',
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Button berhasil ditekan')),
              );
            },
            icon: const Icon(Icons.touch_app),
            label: const Text('Button Action'),
          ),

          const SizedBox(height: 12),

          const Text(
            'Tap card untuk feedback SnackBar.\n'
            'Tekan icon hati untuk Favorite.\n'
            'Long press card untuk melihat informasi.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
