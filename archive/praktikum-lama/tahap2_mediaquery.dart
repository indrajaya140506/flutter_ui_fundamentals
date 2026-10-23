import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap2MediaQueryPage extends StatelessWidget {
  const Tahap2MediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    final layoutType = size.width < 600 ? 'Compact' : 'Wide';

    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 2 - MediaQuery')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone_android, size: 70),
              const SizedBox(height: 24),

              Text(
                studentName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(studentId, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 30),

              Text(
                'Width: ${size.width.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18),
              ),

              Text(
                'Height: ${size.height.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18),
              ),

              Text(
                'Orientation: $orientation',
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.shade100,
                ),
                child: Text(
                  layoutType,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
