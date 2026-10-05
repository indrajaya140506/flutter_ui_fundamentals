import 'package:flutter/material.dart';

const String studentName = 'Komang Indrajaya Darmawiguna';
const String studentId = '2455011001';

class Tahap16DebuggingPage extends StatelessWidget {
  const Tahap16DebuggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 16 - Debugging Challenge'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kasus A'),
              Tab(text: 'Kasus B'),
              Tab(text: 'Kasus C'),
              Tab(text: 'Kasus D'),
            ],
          ),
        ),

        // Tidak menggunakan const di sini
        body: TabBarView(children: [CaseA(), CaseB(), CaseC(), CaseD()]),
      ),
    );
  }
}

// ============================================================
// KASUS A - RENDERFLEX OVERFLOW
// ============================================================

class CaseA extends StatelessWidget {
  const CaseA({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus A - RenderFlex Overflow',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          const Text(
            'Masalah: Row memiliki teks panjang yang dapat '
            'menyebabkan overflow ke luar layar.',
          ),

          const SizedBox(height: 20),

          const Text(
            'Solusi: menggunakan Expanded pada Text.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // SOLUSI OVERFLOW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info),
              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  '$studentId - $studentName - '
                  'Ini adalah teks yang sangat panjang '
                  'untuk menguji dan memperbaiki masalah '
                  'RenderFlex overflow pada Row.',
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Mengapa solusi bekerja?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'Expanded memberikan batas ruang kepada Text '
            'sesuai dengan ruang yang tersedia. Teks kemudian '
            'dapat melakukan wrapping ke baris berikutnya '
            'sehingga tidak keluar dari batas layar.',
          ),

          const SizedBox(height: 30),

          const Divider(),

          const SizedBox(height: 20),

          const Text(
            'Identitas Mahasiswa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text('Nama: $studentName'),
          Text('NIM: $studentId'),
        ],
      ),
    );
  }
}

// ============================================================
// KASUS B - UNBOUNDED HEIGHT
// ============================================================

class CaseB extends StatelessWidget {
  const CaseB({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus B - Unbounded Height',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          const Text(
            'Masalah: ListView di dalam Column tanpa '
            'batas tinggi dapat menyebabkan error '
            '"Vertical viewport was given unbounded height".',
          ),

          const SizedBox(height: 20),

          const Text(
            'Solusi: memberikan batas tinggi menggunakan SizedBox.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // SOLUSI UNBOUNDED HEIGHT
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Item Course ${index + 1}'),
                  subtitle: const Text('Data course pembelajaran Flutter'),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Mengapa solusi bekerja?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'ListView membutuhkan batas tinggi agar Flutter '
            'mengetahui ruang yang tersedia untuk melakukan '
            'scroll. SizedBox memberikan batas tinggi sebesar '
            '300 pixel kepada ListView.',
          ),

          const SizedBox(height: 30),

          const Divider(),

          const SizedBox(height: 20),

          const Text(
            'Identitas Mahasiswa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text('Nama: $studentName'),
          Text('NIM: $studentId'),
        ],
      ),
    );
  }
}

// ============================================================
// KASUS C - KEYBOARD OVERFLOW
// ============================================================

class CaseC extends StatefulWidget {
  const CaseC({super.key});

  @override
  State<CaseC> createState() => _CaseCState();
}

class _CaseCState extends State<CaseC> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Form berhasil dikirim')));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kasus C - Keyboard Overflow',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              const Text(
                'Masalah: ketika keyboard muncul, bagian bawah '
                'form dapat tertutup atau menyebabkan overflow.',
              ),

              const SizedBox(height: 20),

              const Text(
                'Solusi: menggunakan SingleChildScrollView.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: commentController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  hintText: 'Tulis komentar...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Komentar wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: submitForm,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim'),
                ),
              ),

              const SizedBox(height: 30),

              const Divider(),

              const SizedBox(height: 20),

              const Text(
                'Identitas Mahasiswa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text('Nama: $studentName'),
              Text('NIM: $studentId'),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KASUS D - NAVIGASI GANDA
// ============================================================

class CaseD extends StatefulWidget {
  const CaseD({super.key});

  @override
  State<CaseD> createState() => _CaseDState();
}

class _CaseDState extends State<CaseD> {
  bool isNavigating = false;

  Future<void> openDetail() async {
    // Mencegah navigasi ganda
    if (isNavigating) {
      return;
    }

    setState(() {
      isNavigating = true;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const NavigationDetailPage();
        },
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isNavigating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kasus D - Navigasi Ganda',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          const Text(
            'Masalah: pengguna dapat menekan tombol '
            'navigasi berkali-kali sehingga route yang sama '
            'ter-push beberapa kali.',
          ),

          const SizedBox(height: 20),

          const Text(
            'Solusi: tombol dinonaktifkan sementara '
            'selama proses navigasi berlangsung.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isNavigating ? null : openDetail,
              icon: const Icon(Icons.arrow_forward),
              label: Text(isNavigating ? 'Membuka...' : 'Buka Detail'),
            ),
          ),

          const Spacer(),

          const Divider(),

          const SizedBox(height: 20),

          const Text(
            'Identitas Mahasiswa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text('Nama: $studentName'),
          Text('NIM: $studentId'),
        ],
      ),
    );
  }
}

// ============================================================
// DETAIL NAVIGATION
// ============================================================

class NavigationDetailPage extends StatelessWidget {
  const NavigationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Detail')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Kembali'),
        ),
      ),
    );
  }
}
