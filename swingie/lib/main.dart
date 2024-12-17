import 'package:flutter/material.dart';
import 'screens/cover_page.dart';

void main() {
  runApp(const SwingieApp());
}

class SwingieApp extends StatelessWidget {
  const SwingieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swingie Golf Coach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const CoverPage(), // Start with CoverPage
    );
  }
}
