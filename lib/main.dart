import 'package:flutter/material.dart';

void main() {
  runApp(const SuperQuestApp());
}

class SuperQuestApp extends StatelessWidget {
  const SuperQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperQuest',
      debugShowCheckedModeBanner: false,
      home: const Placeholder(),
    );
  }
}
