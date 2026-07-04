import 'package:flutter/material.dart';
import 'package:sufian_group/screens/construction_landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUFIAN GROUP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF95E14)),
        useMaterial3: true,
      ),
      home: const ConstructionLandingPage(),
    );
  }
}
