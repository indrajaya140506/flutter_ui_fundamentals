import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentNim = '2455011001';

class Tahap4ValueNotifierPage extends StatefulWidget {
  const Tahap4ValueNotifierPage({super.key});

  @override
  State<Tahap4ValueNotifierPage> createState() =>
      _Tahap4ValueNotifierPageState();
}

class _Tahap4ValueNotifierPageState extends State<Tahap4ValueNotifierPage> {
  // ValueNotifier menyimpan satu nilai yang bisa diamati.
  final ValueNotifier<int> favoriteCount = ValueNotifier<int>(0);

  void addFavorite() {
    favoriteCount.value++;
  }

  void removeFavorite() {
    if (favoriteCount.value > 0) {
      favoriteCount.value--;
    }
  }

  @override
  void dispose() {
    // Lepaskan listener ketika halaman tidak digunakan lagi.
    favoriteCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tahap 4 - ValueNotifier')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text(studentName),
              subtitle: const Text('NIM: $studentNim'),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Penghitung Favorit',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Ubah jumlah favorit dan amati nilainya secara langsung.'),
          const SizedBox(height: 24),

          // Widget ini hanya membangun ulang bagian yang mendengarkan nilai.
          ValueListenableBuilder<int>(
            valueListenable: favoriteCount,
            builder: (context, value, child) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 48),
                      const SizedBox(height: 12),
                      const Text('Jumlah Favorit'),
                      Text(
                        '$value',
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: addFavorite,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: removeFavorite,
                  icon: const Icon(Icons.remove),
                  label: const Text('Kurangi'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Perbandingan:\n\n'
                'setState(): membangun ulang widget yang '
                'bergantung pada state di dalam subtree terkait.\n\n'
                'ValueNotifier: memberi tahu listener ketika '
                'value berubah. ValueListenableBuilder membangun '
                'ulang bagian UI yang mendengarkan nilai tersebut.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
