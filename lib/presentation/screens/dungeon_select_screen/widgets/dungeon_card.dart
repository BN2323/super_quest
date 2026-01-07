import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class DungeonCard extends StatelessWidget {
  final Dungeon dungeon;
  final VoidCallback? onTap;

  const DungeonCard({
    super.key, 
    required this.dungeon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color;
    final IconData icon;

    if (dungeon.isLocked) {
      color = AppColors.roomLocked;
      icon = Icons.lock;
    } else if (dungeon.isCompleted) {
      color = AppColors.success;
      icon = Icons.check_circle;
    } else {
      color = AppColors.primary;
      icon = Icons.play_arrow;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.7),
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: AppSpacing.sm),
            Text(
              dungeon.name,
              style: AppTextStyles.subtitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              dungeon.theme,
              style: AppTextStyles.label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
