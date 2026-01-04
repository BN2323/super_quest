import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/data/mock/mock_game_data.dart';
import 'package:super_quest/domain/services/challenge_service.dart';
import 'package:super_quest/domain/services/game_service.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/app_entry.dart';

void main() {
  runApp(const SuperQuestApp());
}

class SuperQuestApp extends StatelessWidget {
  const SuperQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameController(
            challengeService: ChallengeService(),
            gameService: GameService(),
            dungeon: MockGameData.dungeon,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SuperQuest',
        home: const AppEntry(),
      ),
    );
  }
}