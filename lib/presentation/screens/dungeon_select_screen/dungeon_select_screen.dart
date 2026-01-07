import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/dugneon_map_screen.dart';
import 'package:super_quest/presentation/screens/dungeon_select_screen/widgets/dungeon_card.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class DungeonSelectScreen extends StatelessWidget {
  const DungeonSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final dungeons = controller.world.dungeons;

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
          itemCount: dungeons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final dungeon = dungeons[index];
            return DungeonCard(
              dungeon: dungeon,
              onTap: dungeon.isLocked
                  ? null
                  : () {
                      controller.selectDungeon(dungeon);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DungeonMapScreen(),
                        ),
                      );
                    },
            );
          },
        ),
      ),
    );
  }
}
