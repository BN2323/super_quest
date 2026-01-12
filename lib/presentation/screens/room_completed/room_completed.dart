import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/screens/dungeon_completed/dungeon_complete_screen.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';

class RoomCompleteScreen extends StatelessWidget {
  final Room room;
  final bool isDungeonCompleted;
  final Dungeon currentDungeon;
  
  const RoomCompleteScreen({
    super.key,
    required this.room, 
    required this.isDungeonCompleted, 
    required this.currentDungeon,
  });

  @override
  Widget build(BuildContext context) {

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
                  label: isDungeonCompleted && room.isBossRoom
                      ? 'FINISH DUNGEON'
                      : 'BACK TO MAP',
                  onPressed: () {
                    if (isDungeonCompleted && room.isBossRoom) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DungeonCompleteScreen(
                            dungeon: currentDungeon,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
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
