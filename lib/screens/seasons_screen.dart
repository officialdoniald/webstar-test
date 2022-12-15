import 'package:flutter/material.dart';
import '../language_constants.dart';

class SeasonsScreen extends StatefulWidget {
  const SeasonsScreen({super.key});

  @override
  State<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        getTranslated(context, 'common_ok'),
      ),
    );
  }
}
