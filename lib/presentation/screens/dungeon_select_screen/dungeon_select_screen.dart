import 'package:flutter/material.dart';
import 'package:super_quest/data/repositories/game_save_repository.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/game_world.dart';
import 'package:super_quest/domain/models/player.dart';
import 'package:super_quest/presentation/screens/dungeon_map/dugneon_map_screen.dart';
import 'package:super_quest/presentation/screens/dungeon_select_screen/widgets/dungeon_card.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class DungeonSelectScreen extends StatefulWidget {
  final GameSaveRepository saveRepository;
  final GameWorld world;
  final Player player;
  
  const DungeonSelectScreen({super.key, required this.saveRepository, required this.world, required this.player});

  @override
  State<DungeonSelectScreen> createState() => _DungeonSelectScreenState();
}

class _DungeonSelectScreenState extends State<DungeonSelectScreen> {
  late Dungeon currentDungeon;
  
  void _selectDungeon(Dungeon dungeon) {
    setState(() {
      currentDungeon = dungeon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Select Dungeon'),
        centerTitle: true,
        backgroundColor: AppColors.background,
        titleTextStyle: AppTextStyles.title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: GridView.builder(
          itemCount: widget.world.dungeons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final dungeon = widget.world.dungeons[index];
            return DungeonCard(
              dungeon: dungeon,
              onTap: dungeon.isLocked
                  ? null
                  : () async {
                      _selectDungeon(dungeon);
                       await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DungeonMapScreen(
                            world: widget.world,
                            player: widget.player,
                            saveRepository: widget.saveRepository,
                            selectedDungeon: currentDungeon,
                          ),
                        ),
                      );

                      setState(() {});
                    },
            );
          },
        ),
      ),
    );
  }
}
