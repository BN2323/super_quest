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
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lv. ${controller.player.level}',
            style: AppTextStyles.subtitle,
          ),
          Column(
            children: [
              Text(
                controller.dungeon.name,
                style: AppTextStyles.title,
              ),
              Text(
                '${controller.currentRoom.order}/${controller.dungeon.rooms.length}',
                style: AppTextStyles.subtitle,
              ),
            ],
          ),
          const Icon(Icons.map, color: AppColors.accent),
        ],
      ),
    );
  }
}
