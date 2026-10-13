import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DebugState(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DebuggingPage(),
      ),
    ),
  );
}

class DebugState extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class DebuggingPage extends StatelessWidget {
  const DebuggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DebugState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 15 - Debugging State'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.bug_report, size: 70, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'DEBUGGING STATE MANAGEMENT',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Nama: Komang Indrajaya Darmawiguna'),
              const Text('NIM: 2455011001'),
              const SizedBox(height: 28),
              const Text('Nilai Counter'),
              Text(
                '${state.counter}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'notifyListeners() memperbarui UI '
                'ketika state berubah.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: state.increment,
                icon: const Icon(Icons.refresh),
                label: const Text('Ubah State'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
