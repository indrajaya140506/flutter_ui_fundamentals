import 'package:flutter/material.dart';

import '../widgets/student_identity_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(
    text: 'Komang Indrajaya Darmawiguna',
  );

  final nimController = TextEditingController(text: '2455011001');

  final commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Feedback Berhasil'),
          content: Text(
            'Terima kasih, ${nameController.text}.\n\n'
            'Komentar:\n${commentController.text}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentIdentityCard(),

            const SizedBox(height: 24),

            const Text(
              'Profile',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text('Software Engineering / TRPL'),

            const SizedBox(height: 28),

            const Text(
              'Feedback Form',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

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
              controller: nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'NIM wajib diisi';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Komentar',
                hintText: 'Minimal 5 karakter',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Komentar wajib diisi';
                }

                if (value.trim().length < 5) {
                  return 'Komentar minimal 5 karakter';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: submitFeedback,
                icon: const Icon(Icons.send),
                label: const Text('Kirim Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
