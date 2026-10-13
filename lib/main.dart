import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tahap6_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(),
      child: const MyApp(),
    ),
  );
}
