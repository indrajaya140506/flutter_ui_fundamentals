import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Meminta izin notifikasi
  Future<AuthorizationStatus> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission: '
      '${settings.authorizationStatus.name}',
    );

    return settings.authorizationStatus;
  }

  // Mendapatkan FCM Token
  Future<String?> getToken() async {
    String? token;

    if (kIsWeb) {
      token = await _messaging.getToken(
        vapidKey:
            'BDx5nbIJ-EhNzNoel-xu3JmnxHby7U9-9c3nxaFYOyeLyUgpdxwEoCsd00rkVJoRtOAeDiWM5FDa9HcLt_YR0-c',
      );
    } else {
      token = await _messaging.getToken();
    }

    debugPrint('FCM Token: $token');

    return token;
  }

  // Mendengarkan perubahan token
  void listenTokenRefresh(void Function(String token) onRefresh) {
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token diperbarui');
      onRefresh(newToken);
    });
  }

  // Menyimpan token ke Supabase (opsional)
  Future<void> saveTokenToSupabase(String token) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) return;

    await Supabase.instance.client.from('device_tokens').upsert({
      'token': token,
      'user_id': user.id,
      'platform': defaultTargetPlatform.name,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  // Inisialisasi Firebase Messaging
  Future<void> init() async {
    try {
      // 1. Meminta permission
      final status = await requestPermission();

      debugPrint('Status permission: ${status.name}');

      if (status != AuthorizationStatus.authorized &&
          status != AuthorizationStatus.provisional) {
        debugPrint('Izin notifikasi belum diberikan.');
        return;
      }

      // 2. Mendapatkan FCM Token
      final token = await getToken();

      if (token != null) {
        debugPrint('FCM Token berhasil diperoleh');

        // Penyimpanan ke Supabase masih opsional.
        // await saveTokenToSupabase(token);
      }

      // 3. Mendengarkan perubahan token
      // Aktifkan jika penyimpanan token ke Supabase digunakan.
      // listenTokenRefresh(saveTokenToSupabase);

      // 4. Pengaturan notifikasi foreground
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // 5. Listener ketika aplikasi sedang terbuka
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('========== FOREGROUND NOTIFICATION ==========');
        debugPrint('Notification received');
        debugPrint('Title : ${message.notification?.title}');
        debugPrint('Body  : ${message.notification?.body}');
        debugPrint('Data  : ${message.data}');
        debugPrint('=============================================');
      });
    } catch (e) {
      debugPrint('Gagal menginisialisasi notifikasi: $e');
    }
  }
}
