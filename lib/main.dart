import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/supabase_config.dart';
import 'providers/tahap10_course_provider.dart';
import 'repositories/course_repository.dart';

import 'tahap14_course_explorer.dart';
import 'services/course_supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Ambil konfigurasi Supabase.
  final url = SupabaseConfig.url;
  final publishableKey = SupabaseConfig.publishableKey;

  if (url.isEmpty || publishableKey.isEmpty) {
    throw StateError(
      'Konfigurasi Supabase belum tersedia. '
      'Atur SUPABASE_URL dan SUPABASE_PUBLISHABLE_KEY.',
    );
  }

  await Supabase.initialize(url: url, publishableKey: publishableKey);

  final courseSupabaseService = CourseSupabaseService();
  final courseRepository = CourseRepository(courseSupabaseService);
  final courseProvider = Tahap10CourseProvider(courseRepository);

  await courseProvider.loadCourses();

  runApp(CourseExplorerApp(courseProvider: courseProvider));
}
