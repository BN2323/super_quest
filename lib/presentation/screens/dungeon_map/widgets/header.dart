import 'package:flutter/material.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class Header extends StatelessWidget {
  final GameController controller;

  const Header({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final player = controller.player;
    final dungeon = controller.currentDungeon;

    final totalRooms = dungeon.rooms.length;
    final completedRooms =
        dungeon.rooms.where((r) => r.isCompleted).length;

    final levelProgress = player.levelProgress;

    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // ===== PLAYER LEVEL =====
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lv. ${player.level}',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: levelProgress.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          // ===== DUNGEON PROGRESS =====
          Column(
            children: [
              Text(
                dungeon.name,
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 4),
              Text(
                '$completedRooms / $totalRooms Rooms',
                style: AppTextStyles.subtitle,
              ),
            ],
          ),

          const SizedBox(width: AppSpacing.md),

          // ===== ICON =====
          const Icon(
            Icons.map,
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }
}
