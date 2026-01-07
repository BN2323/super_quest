import 'package:flutter/material.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class FeedbackText extends StatelessWidget {
  final String message;

  const FeedbackText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Text(
        message,
        style: AppTextStyles.subtitle.copyWith(
          color: AppColors.error,
        ),
      ),
    );
  }
}
