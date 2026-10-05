import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap1LayoutPage extends StatelessWidget {
  const Tahap1LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 1 - Responsive Layout')),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(16),
          color: Colors.blue.shade100,
          child: Text(
            '$studentId - $studentName',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
