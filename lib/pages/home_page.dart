import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../widgets/role_guard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService().getMyProfile();
  }

  Future<void> _logout() async {
    try {
      await AuthService.instance.logout();
      // Navigasi ke LoginPage ditangani oleh listener
      // signedOut di main.dart.
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal logout: $e')));
    }
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'owner':
        return 'Pemilik Kos';
      case 'seeker':
        return 'Pencari Kos';
      case 'admin':
        return 'Administrator';
      default:
        return role;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snap.hasError || snap.data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('KosFinder')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  snap.hasError
                      ? 'Gagal memuat profil:\n${snap.error}'
                      : 'Data profil tidak ditemukan',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        final p = snap.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('KosFinder (${p.role})'),
            actions: [
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            ],
          ),

          body: ListView(
            children: [
              // Informasi pengguna
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(p.name.isEmpty ? p.email : p.name),
                subtitle: Text('${p.email} • ${_roleLabel(p.role)}'),
              ),

              const Divider(),

              // Menu untuk semua role
              const ListTile(
                leading: Icon(Icons.list),
                title: Text('Daftar Kos'),
                subtitle: Text('Lihat daftar kos yang tersedia'),
              ),

              // Menu khusus owner dan admin
              if (p.isOwner || p.isAdmin)
                const ListTile(
                  leading: Icon(Icons.home_work),
                  title: Text('My Kos'),
                  subtitle: Text('Kelola kos milik Anda'),
                ),

              // Menu khusus admin
              if (p.isAdmin)
                const ListTile(
                  leading: Icon(Icons.admin_panel_settings),
                  title: Text('Kelola Data (Admin)'),
                  subtitle: Text('Kelola data aplikasi'),
                ),

              const SizedBox(height: 20),

              // Informasi role aktif
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hak Akses Pengguna',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Anda login sebagai ${_roleLabel(p.role)}.'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Tombol hanya muncul untuk owner dan admin
          floatingActionButton: RoleGuard(
            role: p.role,
            allowed: const ['owner', 'admin'],
            child: FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fitur Tambah Kos siap dikembangkan.'),
                  ),
                );
              },
              icon: const Icon(Icons.add_home),
              label: const Text('Tambah Kos'),
            ),
          ),
        );
      },
    );
  }
}
