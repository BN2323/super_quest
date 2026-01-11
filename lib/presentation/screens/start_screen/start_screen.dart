import 'package:flutter/material.dart';
import 'package:super_quest/data/data/game_data.dart';
import 'package:super_quest/data/datasource/local_game_save_data_source.dart';
import 'package:super_quest/data/repositories/game_save_repository.dart';
import 'package:super_quest/domain/models/game_world.dart';
import 'package:super_quest/domain/models/player.dart';
import 'package:super_quest/presentation/screens/dungeon_select_screen/dungeon_select_screen.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

class StartScreen extends StatefulWidget {
  
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late GameSaveRepository saveRepository;
  late GameWorld world;
  late Player player;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    world = GameData.world;
    player = Player.initial();
    saveRepository = GameSaveRepository(LocalGameSaveDataSource());
    loadGame();
  }

  Future<void> loadGame() async {
  final save = await saveRepository.load();

  if (save != null) {
    player.level = save.level;
    player.xp = save.xp;

    for (final dungeonProgress in save.dungeons) {
      final dungeon = world.dungeons.firstWhere(
        (d) => d.id == dungeonProgress.dungeonId,
        orElse: () => throw Exception('Dungeon not found'),
      );

      dungeon.status = dungeonProgress.status;

      for (final roomProgress in dungeonProgress.rooms) {
        final room = dungeon.rooms.firstWhere(
          (r) => r.id == roomProgress.roomId,
          orElse: () => throw Exception('Room not found'),
        );

        room.status = roomProgress.status;
        room.currentChallengeIndex = roomProgress.challengeIndex;
      }
    }
  }

  setState(() {
    isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SuperQuest',
                  style: AppTextStyles.titleLarge,
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'Conquer logic dungeons\none room at a time',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: AppSpacing.xl),

                PrimaryActionButton(
                  label: isLoading ? 'Loading...' : 'START ADVENTURE',
                  onPressed: () { 
                    isLoading ? null : goToDungeonSelect(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToDungeonSelect(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DungeonSelectScreen(
          world: world,
          player: player,
          saveRepository: saveRepository,),
      ),
    );
  }
}
