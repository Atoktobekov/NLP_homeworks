import 'package:flutter/material.dart';
import 'view/home_page.dart';

void main() {
  runApp(const NGramApp());
}

class NGramApp extends StatelessWidget {
  const NGramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N-Gram Analyzer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
