import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/submit_result.dart';
import 'package:super_quest/presentation/screens/result/widgets/star_row.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';

class ChallengeResultDialog extends StatelessWidget {
  final SubmitResult outcome;
  final bool isRoomComplete;
  final VoidCallback onNext;
  final VoidCallback onReturn;

  const ChallengeResultDialog({
    super.key,
    required this.outcome,
    required this.isRoomComplete,
    required this.onNext,
    required this.onReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ===== TITLE =====
            Text(
              isRoomComplete ? 'Room Complete!' : 'Challenge Complete!',
              style: AppTextStyles.title,
            ),

            const SizedBox(height: AppSpacing.md),

            // ===== STARS =====
            StarRow(outcome.outcome.stars),

            const SizedBox(height: AppSpacing.sm),

            // ===== STATS =====
            Text('XP Gained: ${outcome.outcome.xpGained}',
                style: AppTextStyles.body),
            Text('Hints Used: ${outcome.outcome.hintsUsed}',
                style: AppTextStyles.bodyMuted),

            const SizedBox(height: AppSpacing.lg),

            // ===== ACTIONS =====
            PrimaryActionButton(
              label: isRoomComplete
                  ? 'CONTINUE'
                  : 'NEXT CHALLENGE',
              onPressed: onNext,
            ),

            if (!isRoomComplete) ...[
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: onReturn,
                child: const Text('RETURN TO MAP'),
              ),
            ],
          ],
        ),
      ),
    );
  }

}
