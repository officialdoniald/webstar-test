import 'package:flutter/material.dart';
import 'package:webstartest/screens/seasons_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webstar Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SeasonsScreen(),
    );
  }
}
