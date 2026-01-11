import 'package:flutter/material.dart';
import 'package:super_quest/presentation/screens/start_screen/start_screen.dart';

void main() {
  runApp(const SuperQuestApp());
}

class SuperQuestApp extends StatelessWidget {
  const SuperQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SuperQuest',
      home: StartScreen(),
    );
  }
}