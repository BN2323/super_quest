import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/code_block_chip.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class SolutionArena extends StatelessWidget {
  final List<CodeBlock> blocks;
  final void Function(CodeBlock) onRemove;

  const SolutionArena({
    super.key,
    required this.blocks,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240, // 🔒 fixed arena
      child: DragTarget<CodeBlock>(
        onAccept: (block) => blocks.add(block),
        builder: (_, __, ___) {
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: blocks.isEmpty
                ? Center(
                    child: Text(
                      'Drop blocks here',
                      style: AppTextStyles.subtitle,
                    ),
                  )
                : Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: blocks.map((b) {
                      return GestureDetector(
                        onTap: () => onRemove(b),
                        child: CodeBlockChip(block: b),
                      );
                    }).toList(),
                  ),
          );
        },
      ),
    );
  }
}
