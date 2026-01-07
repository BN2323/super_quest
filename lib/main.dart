import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/data/datasource/local_game_save_data_source.dart';
import 'package:super_quest/data/data/game_data.dart';
import 'package:super_quest/data/repositories/game_save_repository.dart';
import 'package:super_quest/domain/services/challenge_service.dart';
import 'package:super_quest/domain/services/game_service.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/start_screen/start_screen.dart';

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
            world: GameData.world,
            saveRepository: GameSaveRepository(LocalGameSaveDataSource(),),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SuperQuest',
        home: StartScreen(),
      ),
    );
  }
}