import 'package:flutter/material.dart';
import '../../../controllers/game_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_text_styles.dart';

class ProgressHeader extends StatelessWidget {
  final GameController controller;

  const ProgressHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lv. ${controller.player.level}',
              style: AppTextStyles.subtitle,
            ),
            Text(
              'Room ${controller.currentRoom.order}/${controller.dungeon.rooms.length}',
              style: AppTextStyles.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
