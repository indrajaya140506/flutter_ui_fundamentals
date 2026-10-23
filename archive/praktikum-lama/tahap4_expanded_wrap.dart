import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap4ExpandedWrapPage extends StatelessWidget {
  const Tahap4ExpandedWrapPage({super.key});

  Widget buildPanel({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skills = [
      'Flutter',
      'Dart',
      'UI Design',
      'Responsive',
      'Git',
      'GitHub',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 4 - Expanded & Wrap')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identitas
            Text(
              studentName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(studentId),

            const SizedBox(height: 24),

            const Text(
              'Pembagian Ruang dengan Expanded',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Expanded 2:1
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: buildPanel(
                      title: 'Panel A',
                      description: 'Expanded flex: 2',
                      icon: Icons.dashboard,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: buildPanel(
                      title: 'Panel B',
                      description: 'Expanded flex: 1',
                      icon: Icons.widgets,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Skill dengan Wrap',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                return Chip(
                  avatar: const Icon(Icons.check_circle, size: 18),
                  label: Text(skill),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            const Text(
              'Flexible',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.info_outline),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    'Flexible memberikan ruang yang lebih longgar kepada child '
                    'dan dapat digunakan ketika ukuran konten tidak selalu '
                    'dapat diprediksi.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
