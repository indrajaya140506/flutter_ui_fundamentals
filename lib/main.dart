import 'package:flutter/material.dart';

import 'practice/tahap2_http_get.dart';
import 'tahap14_course_explorer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Pengujian HTTP GET sementara untuk Tahap 2.
  testHttpGet();

  runApp(const CourseExplorerApp());
}
