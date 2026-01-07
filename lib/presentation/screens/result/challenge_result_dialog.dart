import 'package:flutter/material.dart';
import 'package:super_quest/presentation/screens/result/widgets/star_row.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';
import '../../../domain/models/challenge_outcome.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class ChallengeResultDialog extends StatelessWidget {
  final ChallengeOutcome outcome;
  final VoidCallback onNext;
  final VoidCallback onReturn;

  const ChallengeResultDialog({
    super.key,
    required this.outcome,
    required this.onNext,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(AppSpacing.lg),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.accent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ROOM CLEARED!',
                style: AppTextStyles.title,
              ),

              const SizedBox(height: AppSpacing.md),

              StarRow(outcome.stars),

              const SizedBox(height: AppSpacing.md),

              Text(
                '+${outcome.xpGained} XP',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.accent,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Hints used: ${outcome.hintsUsed} / 2',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              PrimaryActionButton(
                label: 'NEXT ROOM',
                onPressed: onNext,
              ),

              const SizedBox(height: AppSpacing.sm),

              TextButton(
                onPressed: onReturn,
                child: Text(
                  'RETURN TO MAP',
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
