import 'package:flutter/material.dart';
import 'tahap16_debugging.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Tahap16DebuggingPage(),
    ),
  );
}
