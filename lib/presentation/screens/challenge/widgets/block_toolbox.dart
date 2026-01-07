import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/presentation/screens/challenge/widgets/code_block_chip.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';

class BlockToolbox extends StatelessWidget {
  final List<CodeBlock> blocks;

  const BlockToolbox({super.key, required this.blocks});

  @override
  Widget build(BuildContext context) {
    final shuffled = List<CodeBlock>.from(blocks)..shuffle();

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shuffled.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) {
          final block = shuffled[i];
          return Draggable<CodeBlock>(
            data: block,
            feedback: CodeBlockChip(block: block),
            childWhenDragging:
                Opacity(opacity: 0.3, child: CodeBlockChip(block: block)),
            child: CodeBlockChip(block: block),
          );
        },
      ),
    );
  }
}
