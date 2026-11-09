import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../services/kos_service.dart';
import '../services/notification_service.dart';
import '../widgets/role_guard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UserProfile?> _profileFuture;
  late Future<List<Map<String, dynamic>>> _kosFuture;

  final KosService _kosService = KosService();

  // ID kos milik User A untuk pengujian RLS.
  final String kosIdMilikUserA = 'd4c52254-0d13-4ee2-a06b-9133c5dc9944';

  // UUID akun User A dari Authentication > Users.
  final String userAId = '9d460a35-359b-46ed-8037-e039b951c660';

  @override
  void initState() {
    super.initState();

    // Memuat profil pengguna
    _profileFuture = ProfileService().getMyProfile();

    // Memuat daftar kos
    _loadKos();

    // Inisialisasi Firebase Messaging
    NotificationService.instance.init();
  }

  // Mengambil daftar kos
  void _loadKos() {
    _kosFuture = _kosService.fetchAll();
  }

  // Logout
  Future<void> _logout() async {
    try {
      await AuthService.instance.logout();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal logout: $e')));
    }
  }

  // Label role
  String _roleLabel(String role) {
    switch (role) {
      case 'owner':
        return 'Pemilik Kos';
      case 'seeker':
        return 'Pencari Kos';
      default:
        return role;
    }
  }

  // Menghapus kos
  Future<void> _deleteKos(String id) async {
    try {
      final success = await _kosService.delete(id);

      if (!mounted) return;

      if (success) {
        setState(_loadKos);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Kos berhasil dihapus')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kos tidak ditemukan atau bukan milik Anda'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus kos: $e')));
    }
  }

  // PENGUJIAN KEAMANAN RLS - PRAKTIK 6
  Future<void> _securityTest(String kosId) async {
    final kos = KosService();

    debugPrint('========== PENGUJIAN RLS ==========');

    // 1. User B mencoba UPDATE data User A
    try {
      final updated = await kos.update(kosId, {'name': 'DIUBAH USER B'});

      debugPrint(
        updated
            ? '[FAIL] User B berhasil mengubah data User A'
            : '[PASS] UPDATE ditolak oleh RLS',
      );
    } on PostgrestException catch (e) {
      debugPrint('[PASS] UPDATE ditolak: ${e.code} - ${e.message}');
    }

    // 2. User B mencoba DELETE data User A
    try {
      final deleted = await kos.delete(kosId);

      debugPrint(
        deleted
            ? '[FAIL] User B berhasil menghapus data User A'
            : '[PASS] DELETE ditolak oleh RLS',
      );
    } on PostgrestException catch (e) {
      debugPrint('[PASS] DELETE ditolak: ${e.code} - ${e.message}');
    }

    // 3. User B mencoba INSERT atas nama User A
    try {
      await Supabase.instance.client.from('kos').insert({
        'owner_id': userAId,
        'name': 'Kos palsu',
        'address': 'Alamat pengujian',
        'price': 1000000,
      });

      debugPrint('[FAIL] INSERT atas nama User A berhasil');
    } on PostgrestException catch (e) {
      debugPrint('[PASS] INSERT ditolak: ${e.code} - ${e.message}');
    }

    debugPrint('========== PENGUJIAN SELESAI ==========');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengujian RLS selesai. Periksa Debug Console.'),
      ),
    );

    setState(_loadKos);
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
        final myId = Supabase.instance.client.auth.currentUser?.id;

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
              // INFORMASI PENGGUNA
              ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(p.name.isEmpty ? p.email : p.name),
                subtitle: Text('${p.email} • ${_roleLabel(p.role)}'),
              ),

              const Divider(),

              // DAFTAR KOS
              const ListTile(
                leading: Icon(Icons.list),
                title: Text('Daftar Kos'),
                subtitle: Text('Lihat daftar kos yang tersedia'),
              ),

              // DATA KOS DARI SUPABASE
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _kosFuture,
                builder: (context, kosSnap) {
                  if (kosSnap.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (kosSnap.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Gagal memuat daftar kos: ${kosSnap.error}'),
                    );
                  }

                  final items = kosSnap.data ?? [];

                  if (items.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Belum ada data kos.'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final kos = items[i];

                      // Memeriksa kepemilikan kos
                      final isMine = kos['owner_id'] == myId;

                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.home_work),
                        ),
                        title: Text(kos['name'] ?? '-'),
                        subtitle: Text(
                          '${kos['address'] ?? '-'} • Rp ${kos['price'] ?? 0}',
                        ),

                        // Tombol hanya muncul pada kos milik sendiri
                        trailing: isMine
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // TODO: Buka form edit kos
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteKos(kos['id'].toString());
                                    },
                                  ),
                                ],
                              )
                            : null,
                      );
                    },
                  );
                },
              ),

              const Divider(),

              // MENU KHUSUS OWNER
              if (p.isOwner)
                const ListTile(
                  leading: Icon(Icons.home_work),
                  title: Text('My Kos'),
                  subtitle: Text('Kelola kos milik Anda'),
                ),

              // INFORMASI ROLE
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

              // TOMBOL PENGUJIAN RLS SEMENTARA
              if (p.isOwner)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _securityTest(kosIdMilikUserA);
                    },
                    icon: const Icon(Icons.security),
                    label: const Text('Uji Keamanan RLS'),
                  ),
                ),
            ],
          ),

          // TAMBAH KOS HANYA UNTUK OWNER
          floatingActionButton: RoleGuard(
            role: p.role,
            allowed: const ['owner'],
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
