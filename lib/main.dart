import 'package:flutter/material.dart';
import 'package:super_quest/presentation/screens/start/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SuperQuest',
      home: StartScreen(),
    );
  }
}