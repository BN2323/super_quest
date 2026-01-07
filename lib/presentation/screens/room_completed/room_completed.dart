import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_complete_screen/dungeon_complete_screen.dart';
import 'package:super_quest/presentation/screens/dungeon_map/dugneon_map_screen.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';

class RoomCompleteScreen extends StatelessWidget {
  final Room room;

  const RoomCompleteScreen({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final bool isDungeonComplete = controller.isCurrentDungeonCompleted;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSpacing.xl),
            
                Icon(
                  room.isBossRoom ? Icons.emoji_events : Icons.check_circle,
                  size: 96,
                  color: AppColors.accent,
                ),
            
                const SizedBox(height: AppSpacing.lg),
            
                Text(
                  room.isBossRoom
                      ? 'Boss Room Cleared!'
                      : 'Room Complete!',
                  style: AppTextStyles.titleLarge,
                  textAlign: TextAlign.center,
                ),
            
                const SizedBox(height: AppSpacing.md),
            
                Text(
                  'You completed all challenges in this room.',
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
            
                const Spacer(),
            
                PrimaryActionButton(
                  label: isDungeonComplete
                      ? 'FINISH DUNGEON'
                      : 'BACK TO MAP',
                  onPressed: () {
                    if (isDungeonComplete) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DungeonCompleteScreen(
                            dungeon: controller.currentDungeon,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DungeonMapScreen(),
                        ),
                      );
                    }
                  },
                ),
            
                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
