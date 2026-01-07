import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class ChallengeHeader extends StatelessWidget {
  final Room room;

  const ChallengeHeader({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            room.name,
            style: AppTextStyles.title,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            room.isCompleted ? 'REPLAY' : 'NEW',
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.accent,
            ),
          ),
        ),
      ],
    );
  }
}
