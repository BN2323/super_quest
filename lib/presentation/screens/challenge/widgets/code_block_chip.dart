import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class CodeBlockChip extends StatelessWidget {
  final CodeBlock block;

  const CodeBlockChip({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _colorForType(block.type),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        block.label,
        style: AppTextStyles.button,
      ),
    );
  }

  Color _colorForType(CodeBlockType type) {
    switch (type) {
      case CodeBlockType.keyword:
        return AppColors.primary;
      case CodeBlockType.condition:
        return AppColors.accent;
      case CodeBlockType.action:
        return AppColors.success;
      case CodeBlockType.value:
        return AppColors.surface;
    }
  }
}
