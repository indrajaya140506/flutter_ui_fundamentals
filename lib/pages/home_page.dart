import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/profile_service.dart';

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
    _loadProfile();
  }

  void _loadProfile() {
    _profileFuture = ProfileService().getMyProfile();
  }

  Future<void> _refreshProfile() async {
    setState(() {
      _loadProfile();
    });

    await _profileFuture;
  }

  Future<void> _logout() async {
    try {
      await AuthService.instance.logout();

      // Perpindahan ke LoginPage ditangani oleh
      // listener signedOut di main.dart.
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal logout: $e')));
    }
  }

  String _roleLabel(String role) {
    switch (role.toLowerCase()) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('KosFinder'),
        actions: [
          IconButton(
            tooltip: 'Muat ulang',
            icon: const Icon(Icons.refresh),
            onPressed: _refreshProfile,
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<UserProfile?>(
        future: _profileFuture,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // Tampilkan error sebenarnya
          if (snap.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 45,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Gagal memuat profil',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('${snap.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _refreshProfile,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Data profil tidak ditemukan
          if (snap.data == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_off_outlined, size: 45),
                  const SizedBox(height: 12),
                  const Text('Data profil tidak ditemukan'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _refreshProfile,
                    child: const Text('Muat Ulang'),
                  ),
                ],
              ),
            );
          }

          final p = snap.data!;

          return RefreshIndicator(
            onRefresh: _refreshProfile,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.person, size: 35),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    p.name.isEmpty ? '-' : p.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Center(child: Text(_roleLabel(p.role))),
                const SizedBox(height: 28),
                const Text(
                  'Informasi Akun',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Nama'),
                        subtitle: Text(p.name.isEmpty ? '-' : p.name),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(p.email),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text('Role'),
                        subtitle: Text(_roleLabel(p.role)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
